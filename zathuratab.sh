# ==================================================================
# FILE     zathuratab.sh
# MACHINE  all
# INFO     open pdfs in zathura within tabbed
#
# DATE     11.01.2013
# OWNER    Bischofberger
# ==================================================================

$(tabbed -c -d >/tmp/tabbed.xid)
zathura -e $(</tmp/tabbed.xid)
