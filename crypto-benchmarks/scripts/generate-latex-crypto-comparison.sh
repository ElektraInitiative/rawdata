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
# RESULTS_DIR - path to the results directory
#
# This scripts converts the data from the results directory into LaTeX tables.

if [ -z $RESULTS_DIR ]
then
	RESULTS_DIR="${PWD}/../results/"
fi

PLUGINS=("no_crypto_plugin" "crypto_openssl" "crypto_gcrypt" "crypto_botan" "fcrypt")

declare -A CAPTIONS
CAPTIONS["no_crypto_plugin"]="No crypto plugin"
CAPTIONS["crypto_openssl"]="Crypto (OpenSSL)"
CAPTIONS["crypto_gcrypt"]="Crypto (libgcrypt)"
CAPTIONS["crypto_botan"]="Crypto (Botan)"
CAPTIONS["fcrypt"]="Fcrypt"

declare -A LABELS
LABELS["no_crypto_plugin"]="no-crypto"
LABELS["crypto_openssl"]="openssl"
LABELS["crypto_gcrypt"]="libgcrypt"
LABELS["crypto_botan"]="botan"
LABELS["fcrypt"]="fcrypt"

declare -A RESULTS
STORED_NR_KEYS=()

print_latex_masked () {
	echo $1 | sed 's/\_/\\\_/g'
}

save_nr_keys () {
	for N in ${STORED_NR_KEYS[@]}
	do
		if [[ $N -eq $1 ]]
		then
			unset N
			return
		fi
	done
	STORED_NR_KEYS+=($1)
	unset N
}

# Read in the raw data
for FILE in `ls $RESULTS_DIR`
do
	if [[ ! $FILE =~ .*\_[0-9]+\.txt ]]
	then
		continue
	fi

	NR_KEYS=`head -n 10 "$RESULTS_DIR/$FILE" | grep "number of keys" | awk '{ print $4; }'`
	save_nr_keys $NR_KEYS	

	for PLUGIN in ${PLUGINS[@]}
	do
		KDB_GET_RESULTS=($(tail -n 66 "$RESULTS_DIR/$FILE" | grep $PLUGIN | awk '{ print $2; }')) 
		KDB_SET_RESULTS=($(head -n 77 "$RESULTS_DIR/$FILE" | grep $PLUGIN | awk '{ print $2; }'))

		RESULTS["$PLUGIN,$NR_KEYS,get"]="${KDB_GET_RESULTS[@]}"
		RESULTS["$PLUGIN,$NR_KEYS,set"]="${KDB_SET_RESULTS[@]}"
	done
done

STORED_NR_KEYS=($(printf "%s\n" "${STORED_NR_KEYS[@]}" | sort -n))

# Generate LaTeX header
echo "% NOTE this file has been generated"
echo "% I would suggest to not change it manually"
echo "\\chapter{Benchmark 1 Results}"

# Generate the LaTeX tables
for METHOD in "get" "set"
do
	for PLUGIN in ${PLUGINS[@]}
	do
		HEADER=$"
\\begin{sidewaystable}
\\centering
\\caption{${CAPTIONS[$PLUGIN]} / kdb $METHOD benchmark results}
\\label{eval-table-${LABELS[$PLUGIN]}-$METHOD}
\\scriptsize
\\begin{tabular}{r|rrrrrrrrrrr}
size (\$n\$) & run 1 & run 2 & run 3 & run 4 & run 5 & run 6 & run 7 & run 8 & run 9 & run 10 & run 11\\\\
\\hline"

		print_latex_masked "$HEADER"
		for NR_KEYS in ${STORED_NR_KEYS[@]}
		do
			LINE="\$${NR_KEYS}\$"
			for RESULT in ${RESULTS[$PLUGIN,$NR_KEYS,$METHOD]}
			do
				LINE="$LINE & \$${RESULT}\$"
			done
			LINE="$LINE \\\\"
			echo $LINE
		done
		echo "\\hline"
		echo "\\end{tabular}"
		echo "\\end{sidewaystable}"
		echo " "
		echo " "
	done
done
