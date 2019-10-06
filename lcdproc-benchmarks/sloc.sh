#!/bin/sh

SOURCE_DIR="$(realpath "$(dirname "$0")")"

if [ "$#" -lt 2 ]; then
    exit 1
fi

BASE_DIR="$1"
OUT_DIR="$2"

scc_run() {
    cd "$BASE_DIR/$1"
    git clean -fx
    scc --no-ignore --no-gitignore -o "$OUT_DIR/sloc.$1.txt"
}

scc_run "master"
scc_run "elektra_lowlevel"
scc_run "elektra_highlevel"
