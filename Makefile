# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile
# MACHINE  all
# INFO     -
#
# DATE     04.03.2022
# OWNER    Bischofberger
# ==================================================================

PREFIX:=/usr/local

SCRIPTS = pcsync \
		  snippy \
		  clipswap \
		  pushemall \
		  statemall \
		  pdfpsize \
		  pdfpextr\
		  beamer\
		  screenshot\
		  notesd\
		  backup\
		  texsessioninit\
		  texlogfilefilter\
		  musicsync\
		  extract\
		  photosort\
		  mxergo\
		  skriptsplit\

all:
	@echo "Scripts installation"

install: all
	@echo "installing scripts to ${DESTDIR}${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f -t ${DESTDIR}${PREFIX}/bin/ ${SCRIPTS}
	@cd ${DESTDIR}${PREFIX}/bin && chmod 0755 ${SCRIPTS}
	@echo "done"

uninstall:
	@echo "removing scripts from ${DESTDIR}${PREFIX}/bin"
	@cd ${DESTDIR}${PREFIX}/bin && rm -f ${SCRIPTS}

.PHONY: all install uninstall
