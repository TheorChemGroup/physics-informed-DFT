# ORCA with piM06-2X functionals
#### Building with Apptainer
Download ORCA 5.0.4 `orca_5_0_4_linux_x86-64_shared_openmpi411.tar.xz`

Use the following procedure with (replace PROCS_NUMBER_FOR_PARALLEL_BUILD with your value) :
```bash
apptainer build --build-arg NPJ=PROCS_NUMBER_FOR_PARALLEL_BUILD inj_orca.sif inj_orca.def
```
#### Usage
piM06-2X
```bash
cp piM06-2X/0066987/* .
apptainer run inj_orca.sif orca piM06-2X-DL.inp > piM06-2X-DL.out
```
piM06-2X-DL
```bash
cp piM06-2X-DL/0933013/* .
apptainer run inj_orca.sif orca piM06-2X-DL.inp > piM06-2X-DL.out
```

## FILE ORGANIZATION

| | |
| --- | --- |
| Figures/ | Directory containing R plots |
| piM06-2X-DL/ | Directory containing piM06-2X-DL parameters for ORCA |
| piM06-2X/ | Directory containing piM06-2X parameters for ORCA |
| README.md | The readme file providing an overview of the repository |
| inj_orca.def | Configuration file for the Apptainer with ORCA quantum chemistry program |
| libxc.patch | Patch file for the Libxc library |
| piM06-2X-DL.inp | ORCA input file example for the piM06-2X-DL calculation |
| piM06-2X.inp | ORCA input file example for the piM06-2X calculation |
