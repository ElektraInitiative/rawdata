#!/bin/sh

SOURCE_DIR="$(realpath "$(dirname "$0")")"

if [ "$#" -lt 2 ]; then
	exit 1
fi

BASE_DIR="$1"
OUT_DIR="$2"

configure_build='git clean -fx > /dev/null 2>&1; sh autogen.sh && ./configure --enable-drivers=bayrad,CFontz,CFontzPacket,curses,CwLnx,glk,lb216,lcdm001,MtxOrb,pyramid,text,hd44780,xosd,linux_input'
full_build="$configure_build && make"
install="sudo make install"
post_install="./post-install.sh"

build_highlevel() {
	cd "$BASE_DIR/bench_highlevel"
	git clean -fx >/dev/null 2>&1
	eval "$full_build" >/dev/null 2>&1
}

callgrind_run_highlevel_server() {
    cd "$BASE_DIR/bench_highlevel"
	sh -c "$install; $post_install; $2" >/dev/null 2>&1
    valgrind --tool=callgrind --dump-instr=yes --collect-jumps=yes --callgrind-out-file="$OUT_DIR/callgrind_LCDd_$3.bench_highlevel.txt" -- LCDd $1
    gprof2dot --format=callgrind "$OUT_DIR/callgrind_LCDd_$3.bench_highlevel.txt" > "$OUT_DIR/callgrind_LCDd_$3.bench_highlevel.dot"
    dot -Tsvg -o "$OUT_DIR/callgrind_LCDd_$3.bench_highlevel.svg" "$OUT_DIR/callgrind_LCDd_$3.bench_highlevel.dot"
	kdb rm -r "user/sw/lcdproc" >/dev/null 2>&1
	kdb mount -12 | grep -E "^(spec)?/sw/lcdproc" | xargs -L1 sudo kdb umount >/dev/null 2>&1
	cd "$BASE_DIR/bench_highlevel"
	sudo make uninstall >/dev/null 2>&1
}

. "$SOURCE_DIR/.configs"

echo "Building ..."
build_highlevel

export QUIT=1

callgrind_run_highlevel_server "-f" "$LCDd_minconf_highlevel" "minconf"

unset QUIT