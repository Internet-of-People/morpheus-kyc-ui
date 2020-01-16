use wasm_bindgen::prelude::*;

//fn err_to_js<E: ToString>(e: E) -> JsValue {
//    JsValue::from(e.to_string())
//}

#[wasm_bindgen]
pub fn ping(message: &str) -> Result<String,JsValue> {
    Ok( format!("Rust received message '{};. It works.", message) )
}
