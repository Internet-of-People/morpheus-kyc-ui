use std::cell::RefCell;
use std::{ffi::{CStr, CString}, os::raw::c_char};

use lazy_static::lazy_static;
use tokio::sync::oneshot;

fn str_in(s: *const c_char) -> String {
    let c_str = unsafe { CStr::from_ptr(s) };
    let s = c_str.to_str().unwrap();
    s.to_owned()
}

fn string_out(s: String) -> *mut c_char  {
    let c_str = CString::new(s).unwrap();
    c_str.into_raw()
}

#[no_mangle]
pub extern "C" fn ping(message_raw: *const c_char) -> *mut c_char{
    let message = str_in(message_raw);
    let reply = format!("You sent '{}'. It works.", message);
    string_out(reply)
}

thread_local!{
    static RUNTIME: RefCell<Option<tokio::runtime::Runtime>> = RefCell::new(None);
}

lazy_static! {
    static ref THREAD: std::thread::JoinHandle<()> =
        std::thread::Builder::new().name("Morpheus Rust thread with Tokio".to_owned()).spawn( || {
            RUNTIME.with( |rt_opt_cell| {
                let mut rt_opt = rt_opt_cell.borrow_mut();
                if let None = *rt_opt {
                    let rt = tokio::runtime::Builder::new().enable_all().basic_scheduler().build().unwrap();
                    rt_opt.replace(rt);
                }
                let (_sender, receiver) = oneshot::channel::<()>();
                rt_opt.as_mut().unwrap().block_on(receiver).unwrap();
            });
        }).unwrap();

}

type PingCallback = extern "C" fn(*mut c_char) -> ();

#[no_mangle]
pub extern "C" fn ping_async(message_raw: *const c_char, callback: PingCallback) -> () {
    lazy_static::initialize(&THREAD);

    let message = str_in(message_raw);
    let reply = format!("You sent '{}'. It works.", message);
    tokio::runtime::Handle::current().spawn( async move {
        callback( string_out(reply) )
    });
}
