
DEPS_PATH=$(shell pwd)


# Prerequisites target
.make-prerequisites:
	@touch $@

# Clean everything when CFLAGS is different
ifneq ($(shell sh -c '[ -f .make-cflags ] && cat .make-cflags || echo none'), $(CFLAGS))
.make-cflags: distclean
	-(echo "$(CFLAGS)" > .make-cflags)
.make-prerequisites: .make-cflags
endif

# Clean everything when LDFLAGS is different
ifneq ($(shell sh -c '[ -f .make-ldflags ] && cat .make-ldflags || echo none'), $(LDFLAGS))
.make-ldflags: distclean
	-(echo "$(LDFLAGS)" > .make-ldflags)
.make-prerequisites: .make-ldflags
endif

distclean:
	-(cd gmp && rm -rf latte) > /dev/null || true
	-(cd mpfr && rm -rf latte) > /dev/null || true
	-(cd mpc && rm -rf latte) > /dev/null || true
	-(rm -f .make-*)

./mp/latte/install/lib/libgmp.a: 
	mkdir -p ./gmp/latte/install ./gmp/latte/build
	cd ./gmp/latte/build && ../../configure --prefix=$(DEPS_PATH)/gmp/latte/install --enable-cxx && make && make install

gmp: ./mp/latte/install/lib/libgmp.a
	echo "build gmp"

./mpfr/configure:
	cd ./mpfr && ./autogen.sh

./mpfr/latte/install/lib/libmpfr.a: gmp ./mpfr/configure
	mkdir -p ./mpfr/latte/install ./mpfr/latte/build 
	cd ./mpfr/latte/build &&  ../../configure --prefix=$(DEPS_PATH)/mpfr/latte/install --with-gmp=$(DEPS_PATH)/gmp/latte/install && make && make install 

mpfr: ./mpfr/latte/install/lib/libmpfr.a
	echo "build mpfr"

./mpc/latte/install/lib/libmpc.a: mpfr
	mkdir -p ./mpc/latte/install ./mpc/latte/build
	cd ./mpc/latte/build && ../../configure --prefix=$(DEPS_PATH)/mpc/latte/install --with-gmp=$(DEPS_PATH)/gmp/latte/install --with-mpfr=$(DEPS_PATH)/mpfr/latte/install 

mpc: ./mpc/latte/install/lib/libmpc.a
	echo "build mpc"	