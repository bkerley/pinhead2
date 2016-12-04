#!/bin/env python -u
from subprocess import call

retval = call(["/usr/bin/qemu-i386-static", "./level2"])

if 0 == retval:
    call(["sudo", "systemctl", "restart", "victory.service"])
    call(["sudo", "systemctl", "enable", "victory.service"])
