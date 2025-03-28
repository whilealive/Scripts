# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile
# OS	   linux
# MACHINE  all
# INFO     -
#
# DATE     28.03.2025
# OWNER    Bischofberger
# ==================================================================

PREFIX:=/usr/local
LINUXDIR:=linux/

LINUX_SCRIPTS = pcsync \
				snippy \
				gitrepwrap\
				pdfpsize \
				pdfpextr\
				backup\
				texlogfilefilter\
				downsizealbumcovers\
				extract\
				photosort\
				skriptsplit\
				swayrenameworkspace\
				swaybmzws\
				bbtop\

#UNIVERSAL_SCRIPTS = \

all:
	@echo "Scripts installation"

install: all
	@echo "installing scripts to ${DESTDIR}${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	#@cp -f -t ${DESTDIR}${PREFIX}/bin/ ${UNIVERSAL_SCRIPTS}
	@cd ${LINUXDIR} && cp -f -t ${DESTDIR}${PREFIX}/bin/ ${LINUX_SCRIPTS}
	@cd ${DESTDIR}${PREFIX}/bin && chmod 0755 ${LINUX_SCRIPTS} ${UNIVERSAL_SCRIPTS}
	@echo "done"

uninstall:
	@echo "removing scripts from ${DESTDIR}${PREFIX}/bin"
	@cd ${DESTDIR}${PREFIX}/bin && rm -f ${LINUX_SCRIPTS} ${UNIVERSAL_SCRIPTS}

.PHONY: all install uninstall
