#!/bin/bash
# Copyright (c) 2018, Peter Nirschl
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# 
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The following environment variables can be set for configuration:
#
# BENCHMARK_BIN - path to the executable file that performs the benchmark
# RESULT_DIR - path to the directory where the results should be stored
# DATASET_ID - identifies the benchmark run
#


# Set defaults for the environment variables
if [ -z $BENCHMARK_BIN ]
then
	BENCHMARK_BIN="/libelektra/build/bin/benchmark_crypto_comparison"
fi

if [ -z $RESULT_DIR ]
then
	RESULT_DIR="${PWD}/../results/"
fi

if [ -z $DATASET_ID ]
then
	DATASET_ID=$(uuidgen)
fi

# start the benchmark runs
for RUN in 1 2 3 4 5 6 7 8 9 10 11 15 17 20 25 30 31 32 35 40 50 51 52 55 56 57 60 70 80 90 100 150 175 200 250 300 350 400 500 1000
do
	rm -f ${HOME}/.config/benchmark*.ecf
	$BENCHMARK_BIN $RUN >> "${RESULT_DIR}/comparison_${DATASET_ID}_${RUN}.txt"
	rm -f ${HOME}/.config/benchmark*.ecf
done

