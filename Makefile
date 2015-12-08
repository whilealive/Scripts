# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile (for Scripts all install)
# MACHINE  all
# INFO     -
#
# DATE     08.12.2015
# OWNER    Bischofberger
# ==================================================================

PREFIX:=/usr/local

SCRIPTS = susp \
		  nmgui \
		  pcsync \
		  trash \
		  zathuratab \
		  vol \
		  vimserv \
		  albumartinflac \
		  snippy \
		  pdfpextr \
		  clipswap \
		  pushemall

MUTTSESSIONDIR = emailsession/
MUTTSCRIPTS    = mbsyncsecure email2

all:
	@echo "Scripts installation"

install:
	@echo "installing scripts to ${DESTDIR}${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f -t ${DESTDIR}${PREFIX}/bin/ ${SCRIPTS}

	@echo "installing emailsession scripts to ${DESTDIR}${PREFIX}/bin"
	@cd ${MUTTSESSIONDIR} && cp -f -t ${DESTDIR}${PREFIX}/bin/ ${MUTTSCRIPTS}

	@cd ${DESTDIR}${PREFIX}/bin && chmod 0755 ${SCRIPTS} ${MUTTSCRIPTS}
	@echo "done"

.PHONY: all install
