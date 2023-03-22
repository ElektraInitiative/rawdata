# Copy-on-Write benchmarks

This directory contains benchmarks of the changetracking implementation by @atmaxinger against the non-changetracking implementation on master at [66fdece03](https://github.com/ElektraInitiative/libelektra/tree/66fdece03827aec000e6f05ad3b9511af27c68e8).

The benchmarks were performed within a minimal Debian 11.5 virtual machine on Proxmox with 4 dedicated Intel(R) Xeon(R) X3450 @ 2.67GHz cores and 8 GiB of memory.
No other VMs were running during benchmarking.

The build was performed via
- `cmake -DCMAKE_BUILD_TYPE=Debug -DKDB_DB_HOME=~/elektra-new/home -DKDB_DB_SYSTEM=~/elektra-new/system -DKDB_DB_SPEC=~/elektra-new/spec -DKDB_DB_USER=elektra-new/user -DCMAKE_CXX_FLAGS=--coverage -DCMAKE_C_FLAGS=--coverage ..`
- `cmake --build . -- -j4`

The massif benchmarks found within the `massif` directory were performed using `valgrind --tool=massif --time-unit=B --max-snapshots=200 --threshold=0.1`. 

The callgrind benchmarks found within the `callgrind` directory were performed using `valgrind --tool=callgrind`.

