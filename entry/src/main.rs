extern crate iron;
extern crate mount;
extern crate staticfile;

use std::path::Path;

use iron::prelude::*;

use mount::Mount;

use staticfile::Static;

fn mount() -> Mount {
    let mut mount = Mount::new();
    mount.mount("/", Static::new(Path::new("priv/www")));

    mount
}

fn main() {
    Iron::new(mount()).http("0.0.0.0:8080").unwrap();
}
