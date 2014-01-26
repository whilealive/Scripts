#!/bin/bash
# ==================================================================
# FILE     musictogo.sh
# MACHINE  laptop (?) --> where the ogg library is...
# INFO     randomly chooses albums from library and copies them to 
#          mobile player
# DEPENDS  "udisk_functions" from the AUR
#
# DATE     26.01.2014
# OWNER    Bischofberger
# ==================================================================

# TODO 
# execute sdbm command from here to mount partition


# variables
library="$HOME/Music"
player="/run/media/$(hostname)/syncstick"  # after mounting with "udisk_functions"
sum=0

# check free space on player
# new global variables: $limit
check_free_space() {
      # mount player with "udisk_functions"
    if [ -e $player ] ; then
        freespace=`df -h $usb_path | awk -F'[^0-9]*' 'NR==2 {print $6}'`
        ((freespace -= 1))  # for safety
    else
        echo "Please plug in player/card and rerun programme."
        exit
    fi
}

# list all albums in a temporary file called "albumlist.tmp"
find_albums() {
    echo -n "Collecting music library information..."
    cd $library
    find . -type d -links 2 > albumlist.tmp                     # search for directories which have no more subdirectories
    nl --number-separator=": " albumlist.tmp > albumlist2.tmp   # add line numbers
    awk '{$1=$1}1' albumlist2.tmp > albumlist.tmp               # delete all leading spaces
    rm albumlist2.tmp
    echo "done."
}

# randomly choose a new album from the list, and check its size
# new global variables: $nextalbum, $albumsize
rand_choose() {
    local max=`wc -l < albumlist.tmp`
    local nextnumbr=`expr $RANDOM % $max`
    nextalbum=`awk -F:\  '$1 ~ /^'$nextnumbr'$/ {print $2}' albumlist.tmp`
    albumsize=`du --block-size=MB -s "$nextalbum" | cut -f1 | grep -o '[0-9]\+'`
}

#rm albumlist.tmp
check_free_space
echo $freespace
find_albums
rand_choose
echo $albumsize
# unmount
