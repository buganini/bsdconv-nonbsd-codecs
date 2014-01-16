PREFIX?=/usr/local
CODECS=
CODECS+=inter/CONVERTZ_SIM
CODECS+=inter/CONVERTZ_TRA
CODECS+=inter/TONGWEN_SP
CODECS+=inter/TONGWEN_SW
CODECS+=inter/TONGWEN_TP
CODECS+=inter/TONGWEN_TW

all: builddir codecs

builddir:
	mkdir -p build/share/bsdconv/from
	mkdir -p build/share/bsdconv/inter
	mkdir -p build/share/bsdconv/to

codecs: builddir
	@for item in ${CODECS} ; do \
		bsdconv-mktable modules/$${item}.txt ./build/share/bsdconv/$${item} ; \
		if [ -e modules/$${item}.c ]; then $(CC) ${CFLAGS} modules/$${item}.c -L./build/lib/ -fPIC -shared -o ./build/share/bsdconv/$${item}.so -lbsdconv ${LIBS} ; fi ; \
	done

clean:
	rm -rf build

installdir:
	mkdir -p ${PREFIX}/share/bsdconv/from
	mkdir -p ${PREFIX}/share/bsdconv/inter
	mkdir -p ${PREFIX}/share/bsdconv/to

install: installdir
	@for item in ${CODECS} ; do \
		install -m 444 build/share/bsdconv/$${item} ${PREFIX}/share/bsdconv/$${item} ; \
		if [ -e build/share/bsdconv/$${item}.so ]; then install -m 444 build/share/bsdconv/$${item}.so ${PREFIX}/share/bsdconv/$${item}.so ; fi ; \
	done
