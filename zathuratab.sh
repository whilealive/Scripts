# ==================================================================
# FILE     zathuratab.sh
# MACHINE  all
# INFO     open pdfs in zathura within tabbed
#
# DATE     11.01.2013
# OWNER    Bischofberger
# ==================================================================

# variables
tempfile=/tmp/tabbed.xid


if [ "$(pidof tabbed)" ]  # tabbed already running
then
	zathura -e $(<$tempfile) $1
else
	$(tabbed -c -d >$tempfile)
	zathura -e $(<$tempfile) $1
fi
