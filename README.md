# ORCA with piM06-2X functionals
#### Building with Apptainer
Download ORCA 5.0.4 `orca_5_0_4_linux_x86-64_shared_openmpi411.tar.xz`

Use the following procedure with :
```bash
apptainer build --build-arg NPJ=32 inj_orca.sif inj_orca.def
```
#### Usage
piM06-2X
```bash
cp piM06-2X/0066987/* .
apptainer run inj_orca.sif orca piM06-2X-DL.inp > piM06-2X-DL.out
```
piM06-2X-DL
```bash
cp -r piM06-2X-DL/0933013/* .
apptainer run inj_orca.sif orca piM06-2X-DL.inp > piM06-2X-DL.out
```
