#!/bin/bash

all: opt allSeeds all_a space single

opt: output
	./analyze_opt.R
allSeeds: output
	./analyze_allSeeds.R
all_a: output
	./analyze_all.R
space: output
	./output_spacecomplexity.R
single: s2 s3 s4 s5 s6 s7

s2: output
	./analyze_single.R 2
s3: output
	./analyze_single.R 3
s4: output
	./analyze_single.R 4
s5: output
	./analyze_single.R 5
s6: output
	./analyze_single.R 6
s7: output
	./analyze_single.R 7
output:
	mkdir output
clean:
	rm -rf output
