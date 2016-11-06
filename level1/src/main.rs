use std::io;

fn main() {
    println!("enter a guess");

    let mut guess = String::new();

    io::stdin().
        read_line(&mut guess).
        expect("failed to read guess");

    let check:u64 = guess.
        trim().
        as_bytes().
        iter().
        enumerate().
        map(|(i, b)| (*b as u64) << ((i as u64) * 2)).
        sum();

    let sum:u64 = guess.
        as_bytes().
        iter().
        map(|b| (*b as u64) + 219).
        sum();

    if check == 578674789 {
        println!("congratulations!");
        println!("http://10.219.2.1:{}", sum);
    } else {
        println!("sorry, didn't match");
    }
}
