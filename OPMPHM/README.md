This folder contains all data and results of the Alteration Predictive Hybrid Search
thesis.

The Runtime of the OPMPHM Build data is in the `mapping` folder.
The OPMPHM Build vs Hsearch Build and The Hybrid Search data is in the `time` folder.

All the in the benchmarked used seeds are in the `data*` folders as `*.seeds` files stored.
The results are in csv format and also in the `data*` folders.

The time benchmarks where made on different systems, the syntax is as follows:

| foldername    | Hardware   |
| ------------- |------------|
| system_0      | i7-6700K   |
| system_1      | i7-3517U   |
| system_2      | 1800X      |

Each folder contains R files and a Makefile that evaluates the results and constructs the charts.
The charts when constructed are in the `output` folder as `tex` files stored.
