# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile (for musictogo)
# MACHINE  all
# INFO     -
#
# DATE     22.05.2014
# OWNER    Bischofberger
# ==================================================================

PREFIX:=/usr/local

all:
	@echo "musictogo installation"

install:
	@echo "installing executables to ${DESTDIR}${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f musictogo ${DESTDIR}${PREFIX}/bin/
	@chmod 0755 ${DESTDIR}${PREFIX}/bin/musictogo
	@echo "done"

.PHONY: all install
