# vim: set ai noet sw=4 ts=4:
# ==================================================================
# FILE     Makefile (for laptop powermanagement)
# MACHINE  all
# INFO     -
#
# DATE     04.08.2014
# OWNER    Bischofberger
# ==================================================================

all:
	@echo "Scripts installation"

install:
	@echo "installing powersave script"
	@cp -f -t /usr/bin/ powersave

	@echo "installing udev rule"
	@mkdir -p /etc/udev/rules.d
	@cp -f -t /etc/udev/rules.d/ 50-powersave.rules

	@echo "installing powersave-after-suspend"
	@mkdir -p /usr/lib/systemd/system-sleep
	@cp -f -t /usr/lib/systemd/system-sleep/ powersave-after-suspend

	@chmod 0755 /usr/bin/powersave \
				/etc/udev/rules.d/50-powersave.rules \
				/usr/lib/systemd/system-sleep/powersave-after-suspend

	@echo "done"

.PHONY: all install
