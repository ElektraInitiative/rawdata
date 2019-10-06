#!/bin/sh

SOURCE_DIR="$(realpath "$(dirname "$0")")"

if [ "$#" -lt 1 ]; then
    exit 1
fi

BASE_DIR="$(mktemp)"
OUT_DIR="$1"

shift 1

SCRIPTS="${*:-sloc compile binsize startup memory callgrind-lcdd}"

lcdproc_master_version="${lcdproc_master_version:-master}"
lcdproc_elektra_lowlevel_version="${lcdproc_elektra_lowlevel_version:-elektra_lowlevel}"
lcdproc_elektra_highlevel_version="${lcdproc_elektra_highlevel_version:-elektra_highlevel}"
lcdproc_bench_master_version="${lcdproc_bench_master_version:-bench_master}"
lcdproc_bench_lowlevel_version="${lcdproc_bench_lowlevel_version:-bench_lowlevel}"
lcdproc_bench_highlevel_version="${lcdproc_bench_highlevel_version:-bench_highlevel}"

cd "$BASE_DIR" || exit 1

git clone 'https://github.com/kodebach/lcdproc' "$BASE_DIR/master"
cp -r "$BASE_DIR/master" "$BASE_DIR/elektra_lowlevel"
cp -r "$BASE_DIR/master" "$BASE_DIR/elektra_highlevel"
cp -r "$BASE_DIR/master" "$BASE_DIR/bench_master"
cp -r "$BASE_DIR/master" "$BASE_DIR/bench_lowlevel"
cp -r "$BASE_DIR/master" "$BASE_DIR/bench_highlevel"

cd "$BASE_DIR/master" || exit 1
git checkout "${lcdproc_master_version}"

cd "$BASE_DIR/elektra_lowlevel" || exit 1
git checkout "${lcdproc_elektra_lowlevel_version}"

cd "$BASE_DIR/elektra_highlevel" || exit 1
git checkout "${lcdproc_elektra_highlevel_version}"

cd "$BASE_DIR/bench_master" || exit 1
git checkout "${lcdproc_bench_master_version}"

cd "$BASE_DIR/bench_lowlevel" || exit 1
git checkout "${lcdproc_bench_lowlevel_version}"

cd "$BASE_DIR/bench_highlevel" || exit 1
git checkout "${lcdproc_bench_highlevel_version}"

echo "running benchmarks: $SCRIPTS"

for s in $SCRIPTS; do
    sh "$SOURCE_DIR/$s.sh" "$BASE_DIR" "$OUT_DIR"
done
