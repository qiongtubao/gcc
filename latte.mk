GCC_SRC_PATH=$(shell pwd)
export LD_LIBRARY_PATH=$(GCC_SRC_PATH)/deps/mpc/latte/install/lib:$(GCC_SRC_PATH)/deps/gmp/latte/install/lib:$(GCC_SRC_PATH)/deps/mpfr/latte/install/lib:$LD_LIBDADY_PATH



DEPENDENCY_TARGETS+= mpc
./deps/mpc/latte/install/lib/libmpc.a: 
	cd deps && $(MAKE) mpc

./latte/install/bin/gcc: ./deps/mpc/latte/install/lib/libmpc.a
	mkdir -p latte/build latte/install 
	echo $(GCC_SRC_PATH)
	cd latte/build && ../../configure --prefix=$(GCC_SRC_PATH)/latte/install --enable-threads=posix --disable-checking --disable-multilib --enable-languages=c,c++ --with-gmp=$(GCC_SRC_PATH)/deps/gmp/latte/install --with-mpfr=$(GCC_SRC_PATH)/deps/mpfr/latte/install --with-mpc=$(GCC_SRC_PATH)/deps/mpc/latte/install && make && make install

all: ./latte/install/bin/gcc
	echo "build gcc"

clean:
	rm -rf latte

distclean:
	cd deps && $(MAKE) distclean