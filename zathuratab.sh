# ==================================================================
# FILE     zathuratab.sh
# MACHINE  all
# INFO     - open pdfs in zathura within tabbed
#          - for use with ranger: add zathuratab in 
#            ~/.config/ranger/rifle.conf
#
# DATE     28.01.2014
# OWNER    Bischofberger
# ==================================================================

# TODO:

# variables
tempfile=/tmp/tabbed.xid



if [ "$(pidof tabbed)" ] ; then  # tabbed already running
    if [ -n "$1" ] ; then
        zathura -e $(<$tempfile) "$1"
    else
        zathura -e $(<$tempfile)
    fi
else
    tabbed -c -d >$tempfile
    if [ -n "$1" ] ; then
        zathura -e $(<$tempfile) "$1"
    else
        zathura -e $(<$tempfile)
    fi
fi
