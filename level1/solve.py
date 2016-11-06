import angr

proj = angr.Project('targete/release/level1')
path_group = proj.factory.path_group(threads=4)
path_group.explore(find=0x39ee, avoid=0x39f0)
