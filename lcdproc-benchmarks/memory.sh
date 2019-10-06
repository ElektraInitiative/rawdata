#!/bin/sh

SOURCE_DIR="$(realpath "$(dirname "$0")")"

if [ "$#" -lt 2 ]; then
    exit 1
fi

BASE_DIR="$1"
OUT_DIR="$2"

configure_build='git clean -fx > /dev/null 2>&1; sh autogen.sh && ./configure CFLAGS="-ggdb -fno-inline" --enable-drivers=bayrad,CFontz,CFontzPacket,curses,CwLnx,glk,lb216,lcdm001,MtxOrb,pyramid,text,hd44780,xosd,linux_input'
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

cleanup_master() {
    cd "$BASE_DIR/bench_master"
    sudo make uninstall >/dev/null 2>&1
}

cleanup_lowlevel() {
    kdb rm -r "user/sw/lcdproc" >/dev/null 2>&1
    cd "$BASE_DIR/bench_lowlevel"
    sudo make uninstall >/dev/null 2>&1
}

cleanup_highlevel() {
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

mem_run() {
    if [ "$1" = "-s" ]; then
        shift
        cmd="sudo gdb"
    else
        cmd="gdb"
    fi

    cd "$BASE_DIR/bench_$1" && echo "$7 $1 $5"
    eval "$install; $2" >/dev/null 2>&1
    eval "$4" >/dev/null 2>&1
    cd "$SOURCE_DIR"
    gdb_tmp="$(mktemp)"
    cat "$SOURCE_DIR/mem_gdb_$1" >"$gdb_tmp"
    {
        echo "run $3"
        echo "python outfile.close()"
        echo "quit"
    } >>"$gdb_tmp"
    echo "" >>"$SOURCE_DIR/gdb.log"
    echo "" >>"$SOURCE_DIR/gdb.log"
    echo "$7 $1 $5" >>"$SOURCE_DIR/gdb.log"
    echo "" >>"$SOURCE_DIR/gdb.log"
    echo "" >>"$SOURCE_DIR/gdb.log"
    $cmd -ex "python outfile=open('$OUT_DIR/memory_$7_$5.bench_$1.txt', 'w')" -x "$gdb_tmp" "$7" >>"$SOURCE_DIR/gdb.log" 2>&1
    echo "" >>"$SOURCE_DIR/gdb.log"
    echo "" >>"$SOURCE_DIR/gdb.log"
    echo "" >>"$SOURCE_DIR/gdb.log"
    if [ "$VERBOSE" != 1 ]; then
        rm "$SOURCE_DIR/gdb.log"
    fi
    rm "$gdb_tmp"
    eval "$6" >/dev/null 2>&1
}

server_mem_run() {
    mem_run "$1" "$2" "$3" "$4" "$5" "$6" LCDd
}

lcdproc_mem_run() {
    mem_run "$1" "$2" "$3" "$4; start_server_$1" "$5" "killall LCDd; $6" lcdproc
}

lcdexec_mem_run() {
    mem_run "$1" "$2" "$3" "$4; start_server_$1" "$5" "killall LCDd; $6" lcdexec
}

lcdvc_mem_run() {
    mem_run -s "$1" "$2" "$3" "$4; start_server_$1" "$5" "killall LCDd; $6" lcdvc
}

. "$SOURCE_DIR/.configs"

echo "Building..."
build_master
build_lowlevel
build_highlevel

export QUIT=1

server_mem_run "master" ":" "-f" "echo '$LCDd_minconf_master' | sudo tee /usr/local/etc/LCDd.conf" "minconf" cleanup_master
server_mem_run "lowlevel" ":" "-f" "$LCDd_minconf_lowlevel" "minconf" cleanup_lowlevel
server_mem_run "highlevel" "$post_install" "-f" "$LCDd_minconf_highlevel" "minconf" cleanup_highlevel

server_mem_run "master" ":" "-f" "echo '$LCDd_smallconf_master' | sudo tee /usr/local/etc/LCDd.conf" "smallconf" cleanup_master
server_mem_run "lowlevel" ":" "-f" "$LCDd_smallconf_lowlevel" "smallconf" cleanup_lowlevel
server_mem_run "highlevel" "$post_install" "-f" "$LCDd_smallconf_highlevel" "smallconf" cleanup_highlevel

server_mem_run "master" ":" "-f" "echo '$LCDd_bigconf_master' | sudo tee /usr/local/etc/LCDd.conf" "bigconf" cleanup_master
server_mem_run "lowlevel" ":" "-f" "$LCDd_bigconf_lowlevel" "bigconf" cleanup_lowlevel
server_mem_run "highlevel" "$post_install" "-f" "$LCDd_bigconf_highlevel" "bigconf" cleanup_highlevel

server_mem_run "master" ":" "-f -p 9993 -r 5" "echo '$LCDd_minconf_master' | sudo tee /usr/local/etc/LCDd.conf" "cmdargs" cleanup_master
server_mem_run "lowlevel" ":" "-f -p 9993 -r 5" "$LCDd_minconf_lowlevel" "cmdargs" cleanup_lowlevel
server_mem_run "highlevel" "$post_install" "-f -p 9993 -r 5" "$LCDd_minconf_highlevel" "cmdargs" cleanup_highlevel

unset QUIT

lcdproc_mem_run "master" ":" "-f" "echo '' | sudo tee /usr/local/etc/lcdproc.conf" "minconf" cleanup_master
lcdproc_mem_run "lowlevel" ":" "-f" ":" "minconf" cleanup_lowlevel
lcdproc_mem_run "highlevel" "$post_install" "-f" ":" "minconf" cleanup_highlevel

lcdproc_mem_run "master" ":" "-f" "echo '$lcdproc_smallconf_master' | sudo tee /usr/local/etc/lcdproc.conf" "smallconf" cleanup_master
lcdproc_mem_run "lowlevel" ":" "-f" "$lcdproc_smallconf_lowlevel" "smallconf" cleanup_lowlevel
lcdproc_mem_run "highlevel" "$post_install" "-f" "$lcdproc_smallconf_highlevel" "smallconf" cleanup_highlevel

lcdproc_mem_run "master" ":" "-f" "echo '$lcdproc_bigconf_master' | sudo tee /usr/local/etc/lcdproc.conf" "bigconf" cleanup_master
lcdproc_mem_run "lowlevel" ":" "-f" "$lcdproc_bigconf_lowlevel" "bigconf" cleanup_lowlevel
lcdproc_mem_run "highlevel" "$post_install" "-f" "$lcdproc_bigconf_highlevel" "bigconf" cleanup_highlevel

lcdproc_mem_run "master" ":" "-f -e 10  C M L T D U" "echo '' | sudo tee /usr/local/etc/lcdproc.conf" "cmdargs" cleanup_master
lcdproc_mem_run "lowlevel" ":" "-f -e 10 C M L T D U" ":" "cmdargs" cleanup_lowlevel
lcdproc_mem_run "highlevel" "$post_install" "-f -e 10 cpu memory load time_date disk uptime" ":" "cmdargs" cleanup_highlevel

lcdexec_mem_run "master" ":" "-f" "echo '$lcdexec_minconf_master' | sudo tee /usr/local/etc/lcdexec.conf" "minconf" cleanup_master
lcdexec_mem_run "lowlevel" ":" "-f" "$lcdexec_minconf_lowlevel" "minconf" cleanup_lowlevel
lcdexec_mem_run "highlevel" "$post_install" "-f" "$lcdexec_minconf_highlevel" "minconf" cleanup_highlevel

lcdexec_mem_run "master" ":" "-f" "echo '$lcdexec_smallconf_master' | sudo tee /usr/local/etc/lcdexec.conf" "smallconf" cleanup_master
lcdexec_mem_run "lowlevel" ":" "-f" "$lcdexec_smallconf_lowlevel" "smallconf" cleanup_lowlevel
lcdexec_mem_run "highlevel" "$post_install" "-f" "$lcdexec_smallconf_highlevel" "smallconf" cleanup_highlevel

lcdexec_mem_run "master" ":" "-f" "echo '$lcdexec_bigconf_master' | sudo tee /usr/local/etc/lcdexec.conf" "bigconf" cleanup_master
lcdexec_mem_run "lowlevel" ":" "-f" "$lcdexec_bigconf_lowlevel" "bigconf" cleanup_lowlevel
lcdexec_mem_run "highlevel" "$post_install" "-f" "$lcdexec_bigconf_highlevel" "bigconf" cleanup_highlevel

lcdvc_mem_run "master" ":" "-f" "echo '' | sudo tee /usr/local/etc/lcdvc.conf" "minconf" cleanup_master
lcdvc_mem_run "lowlevel" ":" "-f" ":" "minconf" cleanup_lowlevel
lcdvc_mem_run "highlevel" "$post_install" "-f" ":" "minconf" cleanup_highlevel

lcdvc_mem_run "master" ":" "-f" "echo '$lcdvc_smallconf_master' | sudo tee /usr/local/etc/lcdvc.conf" "smallconf" cleanup_master
lcdvc_mem_run "lowlevel" ":" "-f" "$lcdvc_smallconf_lowlevel" "smallconf" cleanup_lowlevel
lcdvc_mem_run "highlevel" "$post_install" "-f" "$lcdvc_smallconf_highlevel" "smallconf" cleanup_highlevel

lcdvc_mem_run "master" ":" "-f" "echo '$lcdvc_bigconf_master' | sudo tee /usr/local/etc/lcdvc.conf" "bigconf" cleanup_master
lcdvc_mem_run "lowlevel" ":" "-f" "$lcdvc_bigconf_lowlevel" "bigconf" cleanup_lowlevel
lcdvc_mem_run "highlevel" "$post_install" "-f" "$lcdvc_bigconf_highlevel" "bigconf" cleanup_highlevel
