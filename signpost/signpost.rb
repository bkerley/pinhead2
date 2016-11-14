require 'socket'

sock = UDPSocket.new
sock.connect "localhost", 1337
sock.send "87551ccb2dd746aa54a2a27716352936", 0
mesg, addr = sock.recv 256, 0

puts mesg
