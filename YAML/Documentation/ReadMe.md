# YAML Benchmark

## Input

This folder contains two manually created files:

- [`keyframes.yaml`](../Input/keyframes.yaml), and
- [`combined.yaml`](../Input/combined.yaml)

. The other files in the [`input`](../Input) directory:

- [`generated.yaml`](../Input/generated.yaml)
- [`generated100000.yaml`](../Input/generated100000.yaml)

, were generated using the script [`generate-yaml`](https://master.libelektra.org/scripts/generate-yaml):

```sh
# Create a YAML file with 1000 lines/keys
scripts/generate-yaml 1000 >filename.yaml
```

. The other files:

- [`generated_10000.yaml`](../Input/generated_10000.yaml)
- [`generated_1000.yaml`](../Input/generated_1000.yaml)
- [`generated_100.yaml`](../Input/generated_100.yaml)
- [`generated_10.yaml`](../Input/generated_10.yaml)
- [`generated_1.yaml`](../Input/generated_1.yaml)

were generated using the following [fish](https://www.fishshell.com) script in the root of the repository:

```fish
set count 10000
set input_directory "YAML/Input"
while test "$count" -ge 1
    head -n "$count" "$input_directory/generated100000.yaml" >"$input_directory/generated$count.yaml"
    set count (math "$count/10")
end
```

.
