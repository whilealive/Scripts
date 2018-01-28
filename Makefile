# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile (for Scripts all install)
# MACHINE  all
# INFO     -
#
# DATE     28.01.2018
# OWNER    Bischofberger
# ==================================================================

PREFIX:=/usr/local

SCRIPTS = nmgui \
		  pcsync \
		  trash \
		  vol \
		  snippy \
		  clipswap \
		  pushemall \
		  statemall \
		  pdfpsize \
		  pdfpextr\
		  pdfTojpg\
		  beamer\
		  screenshot\
		  abookGroups\
		  abookExport\
		  notesd\
		  backup\
		  texsessioninit

MUTTSESSIONDIR   = emailsession/
MUTTSCRIPTS      = mbsyncsecure email emailsessioninit

ALLSCRIPTS = ${SCRIPTS} ${MUTTSCRIPTS}

all:
	@echo "Scripts installation"

install:
	@echo "installing scripts to ${DESTDIR}${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f -t ${DESTDIR}${PREFIX}/bin/ ${SCRIPTS}

	@echo "installing emailsession scripts to ${DESTDIR}${PREFIX}/bin"
	@cd ${MUTTSESSIONDIR} && cp -f -t ${DESTDIR}${PREFIX}/bin/ ${MUTTSCRIPTS}

	@cd ${DESTDIR}${PREFIX}/bin && chmod 0755 ${ALLSCRIPTS}
	@echo "done"

.PHONY: all install
