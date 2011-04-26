PREFIX?=/usr/local
TODO_CODECS_TABLE=
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
.	for item in ${TODO_CODECS_TABLE}
	bsdconv_mktable codecs/${item}.txt ./build/share/bsdconv/${item}
.	endfor

codecs_callback: builddir
.	for item in ${TODO_CODECS_CALLBACK}
	$(CC) ${CFLAGS} -fPIC -shared -o ./build/share/bsdconv/${item}.so codecs/${item}.c
.	endfor

clean:
	rm -rf build

install:
.	for item in ${TODO_CODECS_TABLE}
	install -m 444 build/share/bsdconv/${item} ${PREFIX}/share/bsdconv/${item}
.	endfor
.	for item in ${TODO_CODECS_CALLBACK}
	install -s -m 444 build/share/bsdconv/${item}.so ${PREFIX}/share/bsdconv/${item}.so
.	endfor
