# MPI Speck Meet-in-the-Middle

Parallel meet-in-the-middle attack on the Speck64/128 block cipher. The project distributes the golden-claw dictionary construction and probe phases across MPI processes and uses OpenMP to speed up local loops, recovering key pairs from two plaintext/ciphertext blocks.

## What’s here
- `mitm.c`: MPI + OpenMP implementation that shards the dictionary build/probe.
- `Problem Description/mitm-intial.c`: sequential baseline.
- `Makefile`: builds `mitm` and provides canned run arguments for several `n` values.
- `Report_Parallel.pdf` and `Problem Description/sujet.pdf`: assignment statement and report.

## Prerequisites
- MPI toolchain (e.g., OpenMPI/MPICH) with `mpicc`.
- OpenMP support in the MPI compiler.
- `make`.

## Build
```sh
make
```

## Run
The Makefile includes presets for several block sizes. Override `NP` (processes) and `n` (bit-size of the keyspace slice) as needed:
```sh
make run NP=4 n=24
```

To run manually with `mpirun`, supply `--n`, `--C0`, and `--C1` (hex ciphertext pairs):
```sh
mpirun -np 4 ./mitm --n 24 --C0 4c143361d238f251 --C1 81d8694e0ef8fdef
```

Larger `n` grows the dictionary as `2^n`; ensure memory fits the chosen block size and process count.
