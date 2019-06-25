# Memory Analysis

The data has been generated using Valgrind's Massif tool.

The runs can be reproduced by executing:

	valgrind --tool=massif  ./benchmark_crypto_comparison 200

where `200` is the size of the key-set that is used for the benchmark.
