#!/usr/bin/python3
"""
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
"""

import re
import sys

DATA_PATH = "../plots/crypto-comparison/median/"
KDB_PHASES = {"get", "set"}
NOCRYPTO = "no_crypto_plugin"
VARIANTS = {NOCRYPTO,"crypto_gcrypt","crypto_openssl","crypto_botan", "fcrypt"}

def parse_file( path, results ):
    with open(path,'r') as f:
        for line in f:
            parts = line.split(' ')
            results[parts[0]] = parts[1]
    f.close()

def calculate_overhead( results, variant, phase ):
    crypto_runtimes = results[phase][variant]
    base_runtimes = results[phase][NOCRYPTO]
    avg = 0.0
    avg_percent = 0.0
    n = len(crypto_runtimes)
    for i in crypto_runtimes:
        crypto_runtime = float(crypto_runtimes[i])
        base_runtime = float(base_runtimes[i])
        avg += (1/n)*(crypto_runtime - base_runtime)
        avg_percent += (1/n)*(crypto_runtime/base_runtime)
    print("avg\t" + phase + "\t" + variant + "\t" + str(round(avg,3)) + " s\t(factor " + str(round(avg_percent,3)) + ")")

def main():
    # initialize the result set
    results = {}
    for phase in KDB_PHASES:
        results[phase] = {}
        for variant in VARIANTS:
            results[phase][variant] = {}
            parse_file(DATA_PATH + phase + "_" + variant + ".dat", results[phase][variant])

    # calculate average overhead and print results
    for phase in KDB_PHASES:
        for variant in VARIANTS:
            if variant == NOCRYPTO:
                continue
            calculate_overhead(results, variant, phase)

if __name__ == "__main__":
    main()

