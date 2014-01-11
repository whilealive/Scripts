# ==================================================================
# FILE     zathuratab.sh
# MACHINE  all
# INFO     open pdfs in zathura within tabbed
#
# DATE     11.01.2013
# OWNER    Bischofberger
# ==================================================================

# TODO:
# if(!exists tabbed.xid)
#     starte tabbed mit zathura und $1
# else
#     redirect zathura mit $1
#
# Dann von ranger diesen Befehl aufrufen

$(tabbed -c -d >/tmp/tabbed.xid)
zathura -e $(</tmp/tabbed.xid)
