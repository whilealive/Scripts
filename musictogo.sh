#!/bin/bash
# ==================================================================
# FILE     musictogo.sh
# MACHINE  laptop (?) --> where the ogg library is...
# INFO     randomly chooses albums from library and copies them to 
#          mobile player
#
# DATE     27.01.2014
# OWNER    Bischofberger
# ==================================================================

# TODO 


# variables
library="$HOME/Music"
player="/run/media/$(hostname)/syncstick"  # after mounting with "udisk_functions"
sum=0

# check free space on player
# --> $freespace
check_free_space() {
    if [ -e $player ] ; then
        freespace=`df --block-size=1K $player | awk -F'[^0-9]*' 'NR==2 {print $5}'`
        #let "freespace -= 1"  # for safety
    else
        echo "Please plug in player/card and rerun programme."
        exit
    fi
}

# list all albums in a temporary file called "albumlist.tmp"
find_albums() {
    echo -n "Collecting music library information..."
    cd $library
    touch albumlist.tmp albumlist2.tmp
    find . -type d -links 2 > albumlist2.tmp  # search for directories which have no more subdirectories
    awk '{ printf("%d\t%s\n", NR, $0) }' albumlist2.tmp > albumlist.tmp
    rm albumlist2.tmp
    echo "done."
}

# randomly choose a new album from the list, and check its size
# --> $nextalbum, $albumsize
rand_choose() {
    local max=`wc -l < albumlist.tmp`
    local nextnumbr=0
    local FLOOR=1
    while [ $nextnumbr -lt $FLOOR ] ; do
        nextnumbr=`expr $RANDOM % $max`
    done
    nextalbum=`awk -F '\t' '$1 ~ /^'$nextnumbr'$/ {print $2}' albumlist.tmp`
    albumsize=`du --block-size=1K -s "$nextalbum" | cut -f1 | grep -o '[0-9]\+'`
}


check_free_space
echo freespace = $freespace
find_albums
rand_choose
echo $nextalbum
echo $albumsize
#rm albumlist.tmp
