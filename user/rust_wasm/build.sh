# cargo install wasm-pack
cargo build
wasm-pack build --target nodejs --out-name rust_integration
