export MUSL_CROSS_PREFIX=$(realpath ./musl-cross-make/output)
export NCURSES_PREFIX=$(realpath ./ncurses_installed)

GDB_VER=8.2

if ! test -d musl-cross-make ; then
7za x musl-cross-make.7z.001
fi

if ! test -d gdb-$GDB_VER ; then
wget -nc https://ftp.gnu.org/gnu/gdb/gdb-8.2.tar.xz
tar -xf gdb-$GDB_VER.tar.xz
fi

cp 0001-hack-enable-curses.patch gdb-$GDB_VER
cd gdb-$GDB_VER
patch -N -p1 -i 0001-hack-enable-curses.patch
cd ..

#if test -d build ; then
#find build -name config.cache -delete
#fi

mkdir -p build
cd build

if ! test -f build/Makefile; then

../gdb-$GDB_VER/configure --host=arm-linux-musleabi --prefix=$MUSL_CROSS_PREFIX	\
  CXXFLAGS="-fPIC -static -DHAVE_NCURSES_NCURSES_H -I$NCURSES_PREFIX/include"	\
  LOADLIBES="$NCURSES_PREFIX/lib/libncurses.a"  --enable-static --disable-shared\
  --disable-libcc1 --with-static-standard-libraries --disable-source-highlight

fi

make -j8
cp ../HACK_build_with_ncurses.patch gdb
cd gdb
patch -N -p1 -i HACK_build_with_ncurses.patch
cd ..
make -j8
cd ..
