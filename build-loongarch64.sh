#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# git submodule init
# git submodule update

# sudo apt install autoconf make libtool wget

# Configure ogg
cd ogg
./autogen.sh
./configure --host=loongarch64-unknown-linux-gnu
cd ..

# Configure build
./autogen.sh
./configure \
  --disable-extra-programs --disable-doc --disable-hardening --disable-stack-protector --enable-custom-modes --enable-dred --enable-osce \
  --host=loongarch64-unknown-linux-gnu
make -j8
strip ./.libs/libopus.so

# Copy result to output directory
LWJGL_OUTPUT_DIR="${LWJGL_OUTPUT_DIR:-/tmp/lwjgl3-build/output}"

mkdir -p "$LWJGL_OUTPUT_DIR"
cp ./.libs/libopus.so "$LWJGL_OUTPUT_DIR/libopus.so"
