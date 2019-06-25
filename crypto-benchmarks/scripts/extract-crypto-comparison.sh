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
# The output of the script is:
# 
# OUTPUT := <METHOD> <PLUGIN> <NR_KEYS> <MEDIAN_TIME>
# METHOD := get, set
# PLUGIN := no_crypto_plugin, crypto_openssl, crypto_gcrypt, crypto_botan, fcrypt
#

if [ -z $RESULTS_DIR ]
then
	RESULTS_DIR="${PWD}/../results/"
fi

PLUGINS=("no_crypto_plugin" "crypto_openssl" "crypto_gcrypt" "crypto_botan" "fcrypt")

for FILE in `ls ${RESULTS_DIR}`
do
	if [[ $FILE =~ .*\_[0-9]+\.txt ]]
	then
		NR_KEYS=`head -n 10 "$RESULTS_DIR/$FILE" | grep "number of keys" | awk '{ print $4; }'`
	else
		continue
	fi

	for PLUGIN in ${PLUGINS[@]}
	do
		KDB_GET_RESULTS=($(tail -n 66 "$RESULTS_DIR/$FILE" | grep $PLUGIN | awk '{ print $2; }' | sort))
		MEDIAN_KDB_GET=${KDB_GET_RESULTS[5]}
		echo "get $PLUGIN $NR_KEYS $MEDIAN_KDB_GET"

		KDB_SET_RESULTS=($(head -n 77 "$RESULTS_DIR/$FILE" | grep $PLUGIN | awk '{ print $2; }' | sort))
		MEDIAN_KDB_SET=${KDB_SET_RESULTS[5]}
		echo "set $PLUGIN $NR_KEYS $MEDIAN_KDB_SET"
	done
done
