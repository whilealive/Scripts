#!/bin/bash
# ==================================================================
# FILE     musictogo.sh
# MACHINE  laptop (?) --> where the ogg library is...
# INFO     randomly chooses albums from library and copies them to 
#          mobile player
#
# DATE     28.01.2014
# OWNER    Bischofberger
# ==================================================================

# TODO 


# variables
library="$HOME/Music"
player="/run/media/$(hostname)/syncstick"  # after mounting with "udisk_functions"
sum=0


die(){
    echo "$0: Error: $1" >&2
    exit 1
}

# delete all content on player
delete_all() {
    if [ -e $player ] ; then
        echo -n "Do you really want to delete ALL content on $player? (y/n) "
        read answer
        if [[ $answer == y ]] ; then
            rm -r $player/* || die "Could not delete content."  # test this
            echo -e "Successfully deleted all content.\n"
            sleep 1
        elif [[ $answer == n ]] ; then
            echo -e "No changes on $player.\n"
            sleep 1
        else
            die "Invalid answer."
        fi
    else
        die "Please plug in player/card and rerun programme."
    fi
}

# check free space on player
# --> $free_space
check_free_space() {
    if [ -e $player ] ; then
        echo "Checking free space on $player..."
        free_space=`df --block-size=1K $player | awk -F'[^0-9]*' 'NR==2 {print $5}'`
        local info_space=`expr $free_space / 1024`
        echo -e "You have approximately $info_space MB free space on $player.\n"
        sleep 1
    else
        die "Please plug in player/card and rerun programme."
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
    echo -e "done.\n"
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


delete_all
check_free_space
find_albums
rand_choose
echo $nextalbum
echo $albumsize
#rm albumlist.tmp
