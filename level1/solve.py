import angr

proj = angr.Project('./target/release/level1')
path_group = proj.factory.path_group(threads=4)
path_group.explore(find=0x896c, avoid=0x8898)
