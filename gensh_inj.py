import sys
import os
import subprocess

outp = "orca/"
home = os.getcwd()
for f in os.listdir("orcabin/"):
    if "." not in f or ".so" in f:
        post = ".bin"
        if ".so" in f:
            post = ""
        comm = "ln -s %s/orcabin/%s %s/orca/%s%s" % (home, f, home, f, post,)
        process = subprocess.Popen(comm, shell=True)
        process.wait()
    if "." not in f:
        with open(home + "/" + outp + f, "w") as fn:
            fn.writelines("""#!/bin/sh
LD_PRELOAD=%s/libxc.so %s/orca/%s.bin $@""" % (2 * (home,) + (f,)))
        process = subprocess.Popen("chmod +x " + home + "/" + outp + f, shell=True)
        process.wait()
