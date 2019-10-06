#!/bin/sh

SOURCE_DIR="$(realpath "$(dirname "$0")")"

if [ "$#" -lt 2 ]; then
	exit 1
fi

BASE_DIR="$1"
OUT_DIR="$2"

hyperfine_run() {
	cd "$BASE_DIR/$1"
	sh -c "$4" >/dev/null 2>&1
	hyperfine --prepare "$3" "$2" --export-json "$OUT_DIR/startup_$5.$1.json"
}

configure_build='git clean -fx > /dev/null 2>&1; sh autogen.sh && ./configure --enable-drivers=bayrad,CFontz,CFontzPacket,curses,CwLnx,glk,lb216,lcdm001,MtxOrb,pyramid,text,hd44780,xosd,linux_input'
full_build="$configure_build && make"
install="sudo make install"
post_install="./post-install.sh"

build_master() {
	cd "$BASE_DIR/bench_master"
	git clean -fx >/dev/null 2>&1
	eval "$full_build" >/dev/null 2>&1
}

build_lowlevel() {
	cd "$BASE_DIR/bench_lowlevel"
	git clean -fx >/dev/null 2>&1
	eval "$full_build" >/dev/null 2>&1
}

build_highlevel() {
	cd "$BASE_DIR/bench_highlevel"
	git clean -fx >/dev/null 2>&1
	eval "$full_build" >/dev/null 2>&1
}

server_run_master() {
	echo "master $3:"
	hyperfine_run "bench_master" "sleep .01; LCDd $1" ":" "$install; $2" "LCDd+10_$3"
	cd "$BASE_DIR/bench_master"
	sudo make uninstall >/dev/null 2>&1
}

server_run_lowlevel() {
	echo "lowlevel $3:"
	hyperfine_run "bench_lowlevel" "sleep .01; LCDd $1" ":" "$install; $2" "LCDd+10_$3"
	kdb rm -r "user/sw/lcdproc" >/dev/null 2>&1
	cd "$BASE_DIR/bench_lowlevel"
	sudo make uninstall >/dev/null 2>&1
}

server_run_highlevel() {
	echo "highlevel $3:"
	hyperfine_run "bench_highlevel" "sleep .01; LCDd $1" ":" "$install; $post_install; $2" "LCDd+10_$3"
	kdb rm -r "user/sw/lcdproc" >/dev/null 2>&1
	kdb mount -12 | grep -E "^(spec)?/sw/lcdproc" | xargs -L1 sudo kdb umount >/dev/null 2>&1
	cd "$BASE_DIR/bench_highlevel"
	sudo make uninstall >/dev/null 2>&1
}

start_server_master() {
	sh -c "$install" >/dev/null 2>&1
	echo "$LCDd_minconf_master" | sudo tee /usr/local/etc/LCDd.conf >/dev/null 2>&1
	LCDd >/dev/null 2>&1 &
}

start_server_lowlevel() {
	sh -c "$install" >/dev/null 2>&1
	eval "$LCDd_minconf_lowlevel" >/dev/null 2>&1
	LCDd >/dev/null 2>&1 &
}

start_server_highlevel() {
	sh -c "$install; $post_install" >/dev/null 2>&1
	eval "$LCDd_minconf_highlevel" >/dev/null 2>&1
	LCDd >/dev/null 2>&1 &
}

cleanup_master() {
	killall LCDd
	cd "$BASE_DIR/bench_master"
	sudo make uninstall >/dev/null 2>&1
}

cleanup_lowlevel() {
	killall LCDd
	kdb rm -r "user/sw/lcdproc" >/dev/null 2>&1
	cd "$BASE_DIR/bench_lowlevel"
	sudo make uninstall >/dev/null 2>&1
}

cleanup_highlevel() {
	killall LCDd
	kdb rm -r "user/sw/lcdproc" >/dev/null 2>&1
	kdb mount -12 | grep -E "^(spec)?/sw/lcdproc" | xargs -L1 sudo kdb umount >/dev/null 2>&1
	cd "$BASE_DIR/bench_highlevel"
	sudo make uninstall >/dev/null 2>&1
}

lcdproc_run_master() {
	cd "$BASE_DIR/bench_master" && echo "master $3:"
	start_server_master
	hyperfine_run "bench_master" "lcdproc $1" ":" "$2" "lcdproc_$3"
	cleanup_master
}

lcdproc_run_lowlevel() {
	cd "$BASE_DIR/bench_lowlevel" && echo "lowlevel $3:"
	start_server_lowlevel
	hyperfine_run "bench_lowlevel" "lcdproc $1" ":" "$2" "lcdproc_$3"
	cleanup_lowlevel
}

lcdproc_run_highlevel() {
	cd "$BASE_DIR/bench_highlevel" && echo "highlevel $3:"
	start_server_highlevel
	hyperfine_run "bench_highlevel" "lcdproc $1" ":" "$2" "lcdproc_$3"
	cleanup_highlevel
}

lcdexec_run_master() {
	cd "$BASE_DIR/bench_master" && echo "master $3:"
	start_server_master
	hyperfine_run "bench_master" "sleep .1; lcdexec $1" ":" "$2" "lcdexec+100_$3"
	cleanup_master
}

lcdexec_run_lowlevel() {
	cd "$BASE_DIR/bench_lowlevel" && echo "lowlevel $3:"
	start_server_lowlevel
	hyperfine_run "bench_lowlevel" "sleep .1; lcdexec $1" ":" "$2" "lcdexec+100_$3"
	cleanup_lowlevel
}

lcdexec_run_highlevel() {
	cd "$BASE_DIR/bench_highlevel" && echo "highlevel $3:"
	start_server_highlevel
	hyperfine_run "bench_highlevel" "sleep .1; lcdexec $1" ":" "$2" "lcdexec+100_$3"
	cleanup_highlevel
}

lcdvc_run_master() {
	cd "$BASE_DIR/bench_master" && echo "master $3:"
	start_server_master
	hyperfine_run "bench_master" "sudo lcdvc $1" ":" "$2" "lcdvc_$3"
	cleanup_master
}

lcdvc_run_lowlevel() {
	cd "$BASE_DIR/bench_lowlevel" && echo "lowlevel $3:"
	start_server_lowlevel
	hyperfine_run "bench_lowlevel" "sudo lcdvc $1" ":" "$2" "lcdvc_$3"
	cleanup_lowlevel
}

lcdvc_run_highlevel() {
	cd "$BASE_DIR/bench_highlevel" && echo "highlevel $3:"
	start_server_highlevel
	hyperfine_run "bench_highlevel" "sudo lcdvc $1" ":" "$2" "lcdvc_$3"
	cleanup_highlevel
}

. "$SOURCE_DIR/.configs"

echo "Building ..."
build_master
build_lowlevel
build_highlevel

export QUIT=1

server_run_master "-f" "echo '$LCDd_minconf_master' | sudo tee /usr/local/etc/LCDd.conf" "minconf"
server_run_lowlevel "-f" "$LCDd_minconf_lowlevel" "minconf"
server_run_highlevel "-f" "$LCDd_minconf_highlevel" "minconf"

server_run_master "-f" "echo '$LCDd_smallconf_master' | sudo tee /usr/local/etc/LCDd.conf" "smallconf"
server_run_lowlevel "-f" "$LCDd_smallconf_lowlevel" "smallconf"
server_run_highlevel "-f" "$LCDd_smallconf_highlevel" "smallconf"

server_run_master "-f" "echo '$LCDd_bigconf_master' | sudo tee /usr/local/etc/LCDd.conf" "bigconf"
server_run_lowlevel "-f" "$LCDd_bigconf_lowlevel" "bigconf"
server_run_highlevel "-f" "$LCDd_bigconf_highlevel" "bigconf"

server_run_master "-f -p 9993 -r 5" "echo '$LCDd_minconf_master' | sudo tee /usr/local/etc/LCDd.conf" "cmdargs"
server_run_lowlevel "-f -p 9993 -r 5" "$LCDd_minconf_lowlevel" "cmdargs"
server_run_highlevel "-f -p 9993 -r 5" "$LCDd_minconf_highlevel" "cmdargs"

unset QUIT

lcdproc_run_master "-f" "echo '' | sudo tee /usr/local/etc/lcdproc.conf" "minconf"
lcdproc_run_lowlevel "-f" ":" "minconf"
lcdproc_run_highlevel "-f" ":" "minconf"

lcdproc_run_master "-f" "echo '$lcdproc_smallconf_master' | sudo tee /usr/local/etc/lcdproc.conf" "smallconf"
lcdproc_run_lowlevel "-f" "$lcdproc_smallconf_lowlevel" "smallconf"
lcdproc_run_highlevel "-f" "$lcdproc_smallconf_highlevel" "smallconf"

lcdproc_run_master "-f" "echo '$lcdproc_bigconf_master' | sudo tee /usr/local/etc/lcdproc.conf" "bigconf"
lcdproc_run_lowlevel "-f" "$lcdproc_bigconf_lowlevel" "bigconf"
lcdproc_run_highlevel "-f" "$lcdproc_bigconf_highlevel" "bigconf"

lcdproc_run_master "-f -e 10 C M L T D U" "echo '$lcdproc_minconf_master' | sudo tee /usr/local/etc/lcdproc.conf" "cmdargs"
lcdproc_run_lowlevel "-f -e 10 C M L T D U" "$lcdproc_minconf_lowlevel" "cmdargs"
lcdproc_run_highlevel "-f -e 10 cpu memory load time_date disk uptime" "$lcdproc_minconf_highlevel" "cmdargs"

lcdexec_run_master "-f" "echo '$lcdexec_minconf_master' | sudo tee /usr/local/etc/lcdexec.conf" "minconf"
lcdexec_run_lowlevel "-f" "$lcdexec_minconf_lowlevel" "minconf"
lcdexec_run_highlevel "-f" "$lcdexec_minconf_highlevel" "minconf"

lcdexec_run_master "-f" "echo '$lcdexec_smallconf_master' | sudo tee /usr/local/etc/lcdexec.conf" "smallconf"
lcdexec_run_lowlevel "-f" "$lcdexec_smallconf_lowlevel" "smallconf"
lcdexec_run_highlevel "-f" "$lcdexec_smallconf_highlevel" "smallconf"

lcdexec_run_master "-f" "echo '$lcdexec_bigconf_master' | sudo tee /usr/local/etc/lcdexec.conf" "bigconf"
lcdexec_run_lowlevel "-f" "$lcdexec_bigconf_lowlevel" "bigconf"
lcdexec_run_highlevel "-f" "$lcdexec_bigconf_highlevel" "bigconf"

lcdvc_run_master "-f" "echo '' | sudo tee /usr/local/etc/lcdvc.conf" "minconf"
lcdvc_run_lowlevel "-f" ":" "minconf"
lcdvc_run_highlevel "-f" ":" "minconf"

lcdvc_run_master "-f" "echo '$lcdvc_smallconf_master' | sudo tee /usr/local/etc/lcdvc.conf" "smallconf"
lcdvc_run_lowlevel "-f" "$lcdvc_smallconf_lowlevel" "smallconf"
lcdvc_run_highlevel "-f" "$lcdvc_smallconf_highlevel" "smallconf"

lcdvc_run_master "-f" "echo '$lcdvc_bigconf_master' | sudo tee /usr/local/etc/lcdvc.conf" "bigconf"
lcdvc_run_lowlevel "-f" "$lcdvc_bigconf_lowlevel" "bigconf"
lcdvc_run_highlevel "-f" "$lcdvc_bigconf_highlevel" "bigconf"
