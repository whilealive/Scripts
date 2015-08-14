# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile (for Scripts all install)
# MACHINE  all
# INFO     -
#
# DATE     14.08.2015
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
		  pdfpextr

MUTTSESSIONDIR = emailsession/
MUTTSCRIPTS    = mbsyncsecure email2
#MUTTSCRIPTS    = mbsyncsecure emailsessioninit email

GITWRAPPERSDIR = git-wrappers/
GITWRAPPERS    = pullemall pushemall mergemall


all:
	@echo "Scripts installation"

install:
	@echo "installing scripts to ${DESTDIR}${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f -t ${DESTDIR}${PREFIX}/bin/ ${SCRIPTS}

	@echo "installing emailsession scripts to ${DESTDIR}${PREFIX}/bin"
	@cd ${MUTTSESSIONDIR} && cp -f -t ${DESTDIR}${PREFIX}/bin/ ${MUTTSCRIPTS}

	@echo "installing git-wrapper scripts to ${DESTDIR}${PREFIX}/bin"
	@cd ${GITWRAPPERSDIR} && cp -f -t ${DESTDIR}${PREFIX}/bin/ ${GITWRAPPERS}

	@cd ${DESTDIR}${PREFIX}/bin && chmod 0755 ${SCRIPTS} ${MUTTSCRIPTS}
	@echo "done"

.PHONY: all install
