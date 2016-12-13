extern crate iron;
extern crate mount;
extern crate staticfile;

use std::path::Path;
use std::process::Command;
use iron::prelude::*;
use iron::status;
use mount::Mount;
use staticfile::Static;

fn unlock(_req: &mut Request) -> IronResult<Response> {
    let _unlocker = Command::new("./priv/open_box").
        output().
        expect("failed to unlock D:");

    Ok(Response::with((status::Ok, "unlocking...")))
}

fn relock(_req: &mut Request) -> IronResult<Response> {
    let _relocker = Command::new("./priv/close_box").
        output().
        expect("failed to relock ¯\\_(ツ)_/¯");

    Ok(Response::with((status::Ok, "relocking...")))
}

fn mount() -> Mount {
    let mut mount = Mount::new();
    mount.mount("/unlock", unlock);
    mount.mount("/relock", relock);
    mount.mount("/", Static::new(Path::new("priv/www")));

    mount
}

fn main() {
    Iron::new(mount()).http("0.0.0.0:5203").unwrap();
}
