# ==================================================================
# FILE     zathuratab.sh
# MACHINE  all
# INFO     - open pdfs in zathura within tabbed
#          - for use with ranger: add zathuratab in 
#            ~/.config/ranger/rifle.conf
#
# DATE     23.01.2013
# OWNER    Bischofberger
# ==================================================================

# TODO:
# handle no argument given

# variables
tempfile=/tmp/tabbed.xid


if [ "$(pidof tabbed)" ]  # tabbed already running
then
	zathura -e $(<$tempfile) "$1"
else
	$(tabbed -c -d >$tempfile)
	zathura -e $(<$tempfile) "$1"
fi
