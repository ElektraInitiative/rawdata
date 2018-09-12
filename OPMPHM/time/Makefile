#!/bin/bash

all: compare opmphm_vs_binary prediction_faster_count prediction_faster_factor

prediction_faster_factor: output
	./analyze_prediction_faster_factor.R

prediction_faster_count: output
	./analyze_prediction_faster_count.R

opmphm_vs_binary: output
	./analyze_opmphm_vs_binary.R

compare: output
	./analyze_compare.R

output:
	mkdir output

clean:
	rm -rf output
