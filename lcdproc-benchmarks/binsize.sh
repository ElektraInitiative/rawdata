#!/bin/sh

SOURCE_DIR="$(realpath "$(dirname "$0")")"

if [ "$#" -lt 2 ]; then
    exit 1
fi

BASE_DIR="$1"
OUT_DIR="$2"

drivers="bayrad,CFontz,CFontzPacket,curses,CwLnx,glk,lb216,lcdm001,MtxOrb,pyramid,text,hd44780,xosd,linux_input"

binaries="server/LCDd $(echo "$drivers" | sed -E -e 's~[^,]+~server/drivers/\0.so~g' -e 's/,/ /g') clients/lcdproc/lcdproc clients/lcdexec/lcdexec clients/lcdvc/lcdvc"

binsize_run() {
    cd "$BASE_DIR/$1"
    git clean -fx >/dev/null 2>&1
    sh autogen.sh >/dev/null 2>&1
    ./configure --enable-drivers=$drivers >/dev/null 2>&1
    make >/dev/null 2>&1

    echo "" >"$OUT_DIR/binsize.$1.txt"
    for binary in $binaries; do
        stat -c "%n: %s" "$binary" >>"$OUT_DIR/binsize.$1.txt"
    done
}

binsize_run "master"
binsize_run "elektra_lowlevel"
binsize_run "elektra_highlevel"
