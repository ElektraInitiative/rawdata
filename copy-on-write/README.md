# Copy-on-Write benchmarks

This directory contains benchmarks of the copy-on-write implementation by @atmaxinger against the non-COW implementation on master at [6147de0](https://github.com/ElektraInitiative/libelektra/tree/6147de07733fec64acef868ed4a7f75af1343c7c).

The benchmarks were performed within a minimal Debian 11.4 virtual machine on Proxmox with 4 dedicated Intel(R) Xeon(R) X3450 @ 2.67GHz cores and 8 GiB of memory.
No other VMs were running during benchmarking.

The build was performed via
- `cmake -DCMAKE_BUILD_TYPE=Release ..`
- `cmake --build . -- -j4`

The massif benchmarks found within the `massif` directory were performed using `valgrind --tool=massif --time-unit=B --max-snapshots=200 --threshold=0.1`. 
The file name schema is `<benchmark name>.<build type>.<branch name>.massif.out`, where the branch name `master` is the master branch and `fbcow` the branch with the copy-on-write implememtation.

The `benchmark_createkeys` application was executed using the command line parameters `200 200`.
