use jsonc_to_json::jsonc_to_json;
use std::io::Read;

fn main() {
    let mut buf = String::new();
    std::io::stdin().read_to_string(&mut buf).unwrap();
    let content = jsonc_to_json(&buf);
    println!("{content}");
}
