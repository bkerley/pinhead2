#!/usr/bin/env python

# docker run --rm -it -v `pwd`:/mnt angr/angr

import angr
import simuvex

proj = angr.Project('./level2', load_options={'auto_load_libs': False})
# state = proj.factory.call_state(0x8048d8e, add_options={simuvex.o.BYPASS_UNSUPPORTED_SYSCALL})
# path = proj.factory.path(state=state)
# ex = proj.surveyors.Explorer(start=path,
#                              find=0x8048e4f,
#                              avoid=(0x80488bb, 0x8048909, 0x8048957, 0x80489a5,
#                                     0x80489f3, 0x8048a41, 0x8048a8f, 0x8048add,
#                                     0x8048b2b, 0x8048b79, 0x8048bc6, 0x8048c14))

# ex.run()

path_group = proj.factory.path_group(threads=32) # Doesn't really help to have more threads, but whatever.

# If we get to 0x402941, "Wrong" is going to be printed out, so definitely avoid that.
path_group.explore(find=0x8048b0f,
                   avoid=(0x8048410))
# If you use anywhere before 0x40292c, angr won't have the flag to print out yet. So don't do that.

print path_group.found[0].state.posix.dumps(0)
print path_group.found[0].state.posix.dumps(1)
