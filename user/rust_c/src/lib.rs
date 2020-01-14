use std::{ffi::{CStr, CString}, os::raw::c_char};

fn move_in(s: *const c_char) -> String {
    let c_str = unsafe { CStr::from_ptr(s) };
    let s = c_str.to_str().unwrap();
    s.to_owned()
}

fn move_out(s: String) -> *mut c_char  {
    let c_str = CString::new(s).unwrap();
    c_str.into_raw()
}

#[no_mangle]
pub extern "C" fn ping(message_raw: *const c_char) -> *mut c_char{
    let message = move_in(message_raw);
    let reply = format!("You sent '{}'. It works.", message);
    move_out(reply)
}
