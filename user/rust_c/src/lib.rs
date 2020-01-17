use std::{ffi::{CStr, CString}, os::raw::c_char};
use std::sync::{Arc, Mutex};

use lazy_static::lazy_static;
use tokio::sync::oneshot;



#[no_mangle]
pub extern "C" fn ping(message_raw: *const c_char) -> *mut c_char{
    let message = str_in(message_raw);
    let reply = format!("You sent '{}'. It works, but blocks.", message);
    string_out(reply)
}



async fn perform_async(message: String, delay_secs: u32) -> String {
    tokio::time::delay_for(std::time::Duration::from_secs(delay_secs.into())).await;
    format!("You sent '{}'. It works even with async operations involved.", message)
}

use std::cell::RefCell;
thread_local!{
    static REACTOR: RefCell<tokio::runtime::Runtime> = RefCell::new(
        tokio::runtime::Builder::new().enable_all().basic_scheduler().build()
            .expect("Failed to initialize Tokio runtime")
     );
}

#[no_mangle]
pub extern "C" fn ping_async_blocking(message_raw: *const c_char, delay_secs: u32) -> *mut c_char {
    let message = str_in(message_raw);
    println!("Blocking on ping call");
    let reply = REACTOR.with(|reactor|
        reactor.borrow_mut().block_on( perform_async(message, delay_secs) )
    );
    println!("Finished blocking");
    string_out(reply)
}



type PingCallback = extern "C" fn(*mut c_char) -> ();

#[no_mangle]
pub extern "C" fn ping_async(message_raw: *const c_char, delay_secs: u32, callback: PingCallback) -> () {
    lazy_static::initialize(&THREAD);

    let message = str_in(message_raw);
    HANDLE.with(|handle|
        handle.spawn( async move {
            let reply = perform_async(message, delay_secs).await;
            callback( string_out(reply) )
        })
    );
}



thread_local!{
    static HANDLE: tokio::runtime::Handle = RUNTIME.lock().unwrap().handle().to_owned();
}

lazy_static! {
    static ref RUNTIME: Arc<Mutex<tokio::runtime::Runtime>> = Arc::new(Mutex::new(
        tokio::runtime::Runtime::new()
            .expect("Failed to initialize Tokio runtime")
    ));

    static ref THREAD: std::thread::JoinHandle<()> = {
        let thread_name = "Morpheus Rust thread running the Tokio event loop".to_owned();
        std::thread::Builder::new().name(thread_name).spawn( move || {
            let (_sender, receiver) = oneshot::channel::<()>();
            RUNTIME.lock().unwrap().block_on(receiver).unwrap();
        }).unwrap()
    };
}



fn str_in(s: *const c_char) -> String {
    let c_str = unsafe { CStr::from_ptr(s) };
    let s = c_str.to_str().unwrap();
    s.to_owned()
}

fn string_out(s: String) -> *mut c_char  {
    let c_str = CString::new(s).unwrap();
    c_str.into_raw()
}
