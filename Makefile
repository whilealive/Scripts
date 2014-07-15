# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile (for Scripts all install)
# MACHINE  all
# INFO     -
#
# DATE     15.07.2014
# OWNER    Bischofberger
# ==================================================================

PREFIX:=/usr/local

SCRIPTS = susp \
		  nmgui \
		  pcsync \
		  pullemall \
		  pushemall \
		  trash \
		  zathuratab \
		  vol \
		  vimserv \
		  albumartinflac

MUTTSESSIONDIR = emailsession/
MUTTSCRIPTS = mbsyncsecure emailsessioninit email

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
