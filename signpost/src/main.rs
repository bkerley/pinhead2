use std::net::UdpSocket;

fn main() {
    let socket = UdpSocket::bind("0.0.0.0:1337").
        expect("failed to bind udp socket");

    socket.
        set_read_timeout(None).
        expect("couldn't set forever timeout");

    loop {
        let mut buf: [u8; 32] = [0; 32];

        let (amt, src) = socket.
            recv_from(&mut buf).
            expect("failed to recv");

        assert!(amt == 32, "recvd {}, wanted 32", amt);

        let expectation = [56, 55, 53, 53, 49, 99, 99, 98, 50, 100, 100, 55, 52,
                           54, 97, 97, 53, 52, 97, 50, 97, 50, 55, 55, 49, 54,
                           51, 53, 50, 57, 51, 54];

        if buf == expectation {
            let reply =
                "nice! http://10.219.0.1:1338 should be available shortly".
                as_bytes();

            socket.
                send_to(reply, &src).
                expect("failed to reply, shit");
        }
    }
}
