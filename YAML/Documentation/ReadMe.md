# YAML Benchmark

## Input

This folder contains two manually created files:

- [`keyframes.yaml`](../Input/keyframes.yaml), and
- [`combined.yaml`](../Input/combined.yaml)

. The other files in the [`input`](../Input) directory:

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
