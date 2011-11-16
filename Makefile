PREFIX?=/usr/local
TODO_CODECS_TABLE=
TODO_CODECS_TABLE+=inter/CONVERTZ_SIM
TODO_CODECS_TABLE+=inter/CONVERTZ_TRA
TODO_CODECS_TABLE+=inter/TONGWEN_SP
TODO_CODECS_TABLE+=inter/TONGWEN_SW
TODO_CODECS_TABLE+=inter/TONGWEN_TP
TODO_CODECS_TABLE+=inter/TONGWEN_TW

TODO_CODECS_CALLBACK=

all: builddir codecs_table codecs_callback

builddir:
	mkdir -p build/share/bsdconv/from
	mkdir -p build/share/bsdconv/inter
	mkdir -p build/share/bsdconv/to

codecs_table: builddir
	@for item in ${TODO_CODECS_TABLE} ; do \
		bsdconv_mktable codecs/$${item}.txt ./build/share/bsdconv/$${item} ; \
	done

codecs_callback: builddir
	@for item in ${TODO_CODECS_CALLBACK} ; do \
		$(CC) ${CFLAGS} -fPIC -shared -o ./build/share/bsdconv/$${item}.so codecs/$${item}.c ; \
	done

clean:
	rm -rf build

installdir:
	mkdir -p ${PREFIX}/share/bsdconv/from
	mkdir -p ${PREFIX}/share/bsdconv/inter
	mkdir -p ${PREFIX}/share/bsdconv/to

install: installdir
	@for item in ${TODO_CODECS_TABLE} ; do \
		install -m 444 build/share/bsdconv/$${item} ${PREFIX}/share/bsdconv/$${item} ; \
	done
	@for item in ${TODO_CODECS_CALLBACK} ; do \
		install -m 444 build/share/bsdconv/$${item}.so ${PREFIX}/share/bsdconv/$${item}.so ; \
	done
