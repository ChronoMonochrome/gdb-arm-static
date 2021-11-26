## A collection of hacks and scripts to cross compile GDB for ARM

Inspired by [gdb-static-cross](https://github.com/stayliv3/gdb-static-cross) (a set of scripts to build gdbserver)

### Build

To start a build, invoke `. build.sh` in the build directory.

The script will start downloading gdb-8.2.tar.xz source code tarball (if wasn't already provided).

Upon finishing the download, a build will begin (beware that it will fail linking GDB, because the build system somehow can't pick up the ncurses library).

Currently the generated Makefile in gdb directory needs to be patched in order to statically link against ncurses (done in the build.sh script).
After patching gdb/Makefile the build should succeed this time.

### How to build musl toolchain

Please refer to [gdb-static-cross](https://github.com/stayliv3/gdb-static-cross) for the build instructions

### ncurses

`ncurses_installed` directory contains headers and a static ncurses library.
To rebuild, use this directory as a prefix when configuring ncurses.
