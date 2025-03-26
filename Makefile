# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile
# OS	   linux
# MACHINE  all
# INFO     -
#
# DATE     26.03.2025
# OWNER    Bischofberger
# ==================================================================

PREFIX:=/usr/local

SCRIPTS = pcsync \
		  snippy \
		  pushemall \
		  statemall \
		  pdfpsize \
		  pdfpextr\
		  screenshot\
		  backup\
		  texlogfilefilter\
		  downsizealbumcovers\
		  extract\
		  photosort\
		  skriptsplit\
		  swayrenameworkspace\
		  swaybmzws\
		  bbtop\

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
