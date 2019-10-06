#!/bin/sh

SOURCE_DIR="$(realpath "$(dirname "$0")")"

if [ "$#" -lt 2 ]; then
	exit 1
fi

BASE_DIR="$1"
OUT_DIR="$2"

hyperfine_run() {
	cd "$BASE_DIR/$1"
	git clean -fx >/dev/null 2>&1
	sh -c "$4" >/dev/null 2>&1
	hyperfine --warmup 1 --prepare "$3" "$2" --export-json "$OUT_DIR/compile_$5.$1.json"
}

configure_build='sh autogen.sh && ./configure --enable-drivers=bayrad,CFontz,CFontzPacket,curses,CwLnx,glk,lb216,lcdm001,MtxOrb,pyramid,text,hd44780,xosd,linux_input'
full_build="$configure_build && make"

compile_full_run() {
	hyperfine_run "$1" "$full_build" "git clean -fx" ":" "full"
}

compile_make_run() {
	hyperfine_run "$1" "make" "make clean" "$configure_build" "make"
}

nokdb_clean="find . -name 'elektragen.[ch]' -exec mv '{}' '{}.bak' \\;"
nokdb_clean="$nokdb_clean ; find . -name '*.mount.sh' -exec mv '{}' '{}.bak' \\;"
nokdb_clean="$nokdb_clean ; find . -name '*.spec.eqd' -exec mv '{}' '{}.bak' \\;"
nokdb_clean="$nokdb_clean ; make clean"
nokdb_clean="$nokdb_clean ; find . -name 'elektragen.[ch].bak' -exec sh -c 'x=\"{}\"; mv \"\$x\" \"\${x%.*}\"' \\;"
nokdb_clean="$nokdb_clean ; find . -name '*.mount.sh.bak' -exec sh -c 'x=\"{}\"; mv \"\$x\" \"\${x%.*}\"' \\;"
nokdb_clean="$nokdb_clean ; find . -name '*.spec.eqd.bak' -exec sh -c 'x=\"{}\"; mv \"\$x\" \"\${x%.*}\"' \\;"

compile_nokdb_run() {
	hyperfine_run "$1" "make" "$nokdb_clean" "$full_build" "nokdb"
}

compile_full_run "master"
compile_full_run "elektra_lowlevel"
compile_full_run "elektra_highlevel"

compile_make_run "master"
compile_make_run "elektra_lowlevel"
compile_make_run "elektra_highlevel"

compile_nokdb_run "elektra_highlevel"
