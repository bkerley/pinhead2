#![feature(alloc_system)]

extern crate alloc_system;

use std::io;

fn calculate_check(guess:&String) -> u64 {
    guess.
        trim().
        as_bytes().
        iter().
        enumerate().
        map(|(i, b)| (*b as u64) << ((i as u64) * 2)).
        sum()
}

fn calculate_portnumber(guess:&String) -> u64 {
    guess.
        as_bytes().
        iter().
        map(|b| (*b as u64) + 219).
        sum()
}

fn main() {
    println!("enter a guess");

    let mut guess = String::new();

    io::stdin().
        read_line(&mut guess).
        expect("failed to read guess");

    let check = calculate_check(&guess);

    let portnum = calculate_portnumber(&guess);

    if check == 155749 {
        println!("congratulations!");
        println!("http://10.219.2.1:{}", portnum);
    } else {
        println!("sorry, didn't match");
    }
}
