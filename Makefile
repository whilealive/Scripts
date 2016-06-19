# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile (for Scripts all install)
# MACHINE  all
# INFO     -
#
# DATE     14.06.2016
# OWNER    Bischofberger
# ==================================================================
# TODO: give uninstall option

PREFIX:=/usr/local

SCRIPTS = nmgui \
		  pcsync \
		  trash \
		  zathuratab \
		  vol \
		  snippy \
		  clipswap \
		  pushemall \
		  statemall \
		  pdfpsize \
		  pdfpextr\
		  beamer\
		  tcplayMount

MUTTSESSIONDIR   = emailsession/
MUTTSCRIPTS      = mbsyncsecure email emailsessioninit

MUSICTOGODIR     = musictogo/
MUSICTOGOSCRIPTS = musictogo

ALLSCRIPTS = ${SCRIPTS} ${MUTTSCRIPTS} ${MUSICTOGOSCRIPTS}

all:
	@echo "Scripts installation"

install:
	@echo "installing scripts to ${DESTDIR}${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f -t ${DESTDIR}${PREFIX}/bin/ ${SCRIPTS}

	@echo "installing emailsession scripts to ${DESTDIR}${PREFIX}/bin"
	@cd ${MUTTSESSIONDIR} && cp -f -t ${DESTDIR}${PREFIX}/bin/ ${MUTTSCRIPTS}

	@echo "installing musictogo script to ${DESTDIR}${PREFIX}/bin"
	@cd ${MUSICTOGODIR} && cp -f -t ${DESTDIR}${PREFIX}/bin/ ${MUSICTOGOSCRIPTS}

	@cd ${DESTDIR}${PREFIX}/bin && chmod 0755 ${ALLSCRIPTS}
	@echo "done"

.PHONY: all install
