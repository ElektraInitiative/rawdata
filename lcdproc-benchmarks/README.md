# Benchmarks for LCDproc

## Running Benchmarks

To run the benchmarks yourself, install Elektra and then use:

```sh
sh benchmark.sh <out-dir>
```

If you only want to run one of the benchmarks, use:

```sh
sh benchmark.sh <out-dir> <benchmark-name>
```

The supported names are:

```
binsize
callgrind-lcdd
compile
memory
sloc
startup
```

## Our Results

Our original results can be found in the `results` directory.

## Copyright Notice

Copyright © 2019 Klemens Böswirth.
All rights reserved.

The content of this directory is released under the BSD 2-Clause License.
Please see [LICENSE](LICENSE) for further details.
