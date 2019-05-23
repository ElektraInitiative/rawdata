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
- [`generated_5000.yaml`](../Input/generated_5000.yaml)
- [`generated_1000.yaml`](../Input/generated_1000.yaml)
- [`generated_500.yaml`](../Input/generated_500.yaml)
- [`generated_100.yaml`](../Input/generated_100.yaml)
- [`generated_50.yaml`](../Input/generated_50.yaml)
- [`generated_10.yaml`](../Input/generated_10.yaml)
- [`generated_5.yaml`](../Input/generated_5.yaml)
- [`generated_1.yaml`](../Input/generated_1.yaml)
- [`generated_0.yaml`](../Input/generated_0.yaml)

were generated using the following [fish](https://www.fishshell.com) script in the root of the repository:

```fish
set count 50000
set input_directory "YAML/Input"
while test "$count" -ge 1
    head -n "$count" "$input_directory/generated_100000.yaml" >"$input_directory/generated_$count.yaml"
    set first_digit (printf '%s' "$count" | head -c 1)
    test "$first_digit" -eq 1 && set count (math "$count/2") || set count (math "$count/5")
end
printf '' >"$input_directory/generated_0.yaml"
```

.
