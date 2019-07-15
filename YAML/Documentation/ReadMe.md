# YAML Benchmark

## Input

This folder contains two manually created files:

- [`keyframes.yaml`](../Input/keyframes.yaml), and
- [`combined.yaml`](../Input/combined.yaml)

. The other files in the [`Input`](../Input) directory:

- [`generated.yaml`](../Input/generated.yaml)
- [`generated_100000.yaml`](../Input/generated_100000.yaml)

, were generated using the script [`generate-yaml`](https://master.libelektra.org/scripts/generate-yaml):

```sh
# Create a YAML file with 1000 lines/keys
scripts/generate-yaml 1000 >filename.yaml
```

. The other files:

- [`generated_50000.yaml`](../Input/generated_50000.yaml)
- [`generated_10000.yaml`](../Input/generated_10000.yaml)
- [`generated_5000.yaml`](../Input/generated_5000.yaml)
- [`generated_1000.yaml`](../Input/generated_1000.yaml)
- [`generated_500.yaml`](../Input/generated_500.yaml)
- [`generated_100.yaml`](../Input/generated_100.yaml)
- [`generated_50.yaml`](../Input/generated_50.yaml)
- [`generated_10.yaml`](../Input/generated_10.yaml)
- [`generated_5.yaml`](../Input/generated_5.yaml)
- [`generated_1.yaml`](../Input/generated_1.yaml)
- [`generated_0.yaml`](../Input/generated_0.yaml)

were generated using the [fish](https://www.fishshell.com) script [`cut_input`](../Scripts/cut_input) in the root of the repository:

```sh
YAML/Scripts/cut_input
```

.

## Flame Graphs

The folder [`Flame Graphs`](../Flame Graphs) contains [flame graphs](http://www.brendangregg.com/flamegraphs.html) created with the LLVM extension [XRay](https://llvm.org/docs/XRay.html). We profiled the code with the [Docker image for Ubuntu Disco Dingo](https://github.com/ElektraInitiative/libelektra/blob/master/scripts/docker/ubuntu/disco/Dockerfile) as described [here](https://github.com/ElektraInitiative/libelektra/blob/master/doc/tutorials/profiling.md#xray).

## Results

### Run Time

The folder [`Run Time`](../Results/Run Time) contains the results of the execution time benchmark for some of [Elektra](https://www.libelektra.org)’s YAML plugins.

#### Setup

All of the runtime benchmark data was created using the script [`benchmark-runtime`](../Scripts/benchmark-runtime). For this script to work, please copy all files you want to use as input from [`Input`](../Input) to the folder `data/benchmarks` inside a local copy of [Elektra’s repository](https://master.libelektra.org). The script assumes that you store the compiled version of Elektra for

- macOS inside the folder `build/mac`, and
- Linux inside the folder `build/linux`

in the root of Elektra’s repository. After you built Elektra you can copy [`benchmark-runtime`](../Scripts/benchmark-runtime) to the root of Elektra’s repository and call it using

```sh
./benchmark-runtime
```

### Memory Usage

The folder [`Memory Usage`](../Results/Memory Usage) contains the results of a heap memory analysis with the tool [Massif](http://valgrind.org/docs/manual/ms-manual.html).

#### Setup

All the data in the folder [`Memory Usage`](../Results/Memory Usage) was generated with the script [`benchmark-memory`](../Scripts/benchmark-memory). For an description on how to use this script, please take a look at the “Setup” subsection of the section “Run Time”, and replace `benchmark-runtime` with the name `benchmark-memory`.

### Line Count

The file [`lines.txt`](../Results/Lines/lines.txt) contains the result of a line count of YAML plugins with the script [`count-lines`](../Scripts/count-lines).

#### Setup

Before you call the script [`count-lines`](../Scripts/count-lines) you need to build Elektra and use `build/mac` inside the root of Elektra’s repository as build folder. Afterwards please copy the script [`count-lines`](../Scripts/count-lines) into the root of Elektra’s repository and call it using the command:

```sh
./count-lines
```

.

### Cyclomatic Complexity

We determined the cyclomatic complexity with the script [`measure-complexity`](../Scripts/measure-complexity). The file [complexity.txt](../Results/Cyclomatic Complexity/complexity.txt) contains the result of this analysis.

#### Setup

To run the complexity analysis you need to copy the script [`measure-complexity`](../Scripts/measure-complexity) into the root of Elektra’s repository. Afterwards build Elektra using `build/mac` as build folder and call the script using the command

```sh
./measure-complexity
```

.
