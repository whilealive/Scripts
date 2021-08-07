# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile
# MACHINE  all
# INFO     -
#
# DATE     07.08.2021
# OWNER    Bischofberger
# ==================================================================

PREFIX:=/usr/local

SCRIPTS = pcsync \
		  vol \
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
		  pwdFetch\
		  musicsync\
		  extract\
		  photosort\

MUTTSESSIONDIR   = emailsession/
MUTTSCRIPTS      = mbsyncsecure email emailsessioninit

ALLSCRIPTS = ${SCRIPTS} ${MUTTSCRIPTS}

all:
	@echo "Scripts installation"

install: all
	@echo "installing scripts to ${DESTDIR}${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f -t ${DESTDIR}${PREFIX}/bin/ ${SCRIPTS}
	@echo "installing emailsession scripts to ${DESTDIR}${PREFIX}/bin"
	@cd ${MUTTSESSIONDIR} && cp -f -t ${DESTDIR}${PREFIX}/bin/ ${MUTTSCRIPTS}
	@cd ${DESTDIR}${PREFIX}/bin && chmod 0755 ${ALLSCRIPTS}
	@echo "done"

uninstall:
	@echo "removing scripts from ${DESTDIR}${PREFIX}/bin"
	@cd ${DESTDIR}${PREFIX}/bin && rm -f ${ALLSCRIPTS}

.PHONY: all install uninstall
