#!/bin/bash
# ==================================================================
# FILE     musictogo.sh
# MACHINE  laptop (?) --> where the ogg library is...
# INFO     randomly chooses albums from library and copies them to 
#          mobile player
#
# DATE     30.01.2014
# OWNER    Bischofberger
# ==================================================================

# TODO 


# paths
library="$HOME/Music"
player="/run/media/$(hostname)/syncstick"  # path after mounting



die(){
    echo -e "$0: Error: $1" >&2
    exit 1
}

# explains usage when giving the "--help" option
usage() {
    echo -e "usage: $0 [OPTION]\n\
Copies whole albums from your local music library to an external player/SD card.\n\

-n, --number=NUMBR  give a maximal number of albums to be exchanged through a random selection
    --help          shows this help
    --version       shows version number
"
    exit 0
}

# delete all content on player
delete_all() {
    if [ -e $player ] ; then
        echo -n "Do you really want to delete ALL content on $player? (y/n) "
        read answer
        if [[ $answer == y ]] ; then
            rm -r $player/* || die "Could not delete content."  # test this
            echo -e "Successfully deleted all content.\n"
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
        echo -n "Would you like to proceed? (y/n) "
        read answer
        if [[ $answer == n ]]  ; then
            exit 1
        fi
        echo
    else
        die "Please plug in player/card and rerun programme."
    fi
}

# list all albums in a temporary file called "albumlist.tmp"
list_albums() {
    echo -n "Collecting music library information..."
    cd $library || die "Directory $library not available on this system."
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

# randomly choose albums until space is full
create_copy_list() {
    echo -n "randomly choosing albums..."
    local size_sum=0
    touch copy_list.tmp
    while (( size_sum < free_space )) ; do
        rand_choose
        if (( (size_sum += albumsize) < free_space )) ; then
            &>>copy_list.tmp echo $nextalbum
        else
            break
        fi
    done
    echo -e "done.\n"
}

# copy everything to player
copy() {
    echo -n "Data is being copied..."

    echo "done."
}
    


# -----------------
# main starts here:
# -----------------
while [ -n "$1" ]; do
    case "$1" in
        "--help")
            usage
            ;;
        "--version")
            echo "musictogo Version 0.1"
            exit 0
            ;;
#        "-n"|"--number")
#            exchange_nmbr=$1
#            shift
#            ;;
        *)
            die "Unknown parameter '$1'.\nGet further information with the \"--help\" option."
            ;;
    esac
done

delete_all
check_free_space
list_albums
create_copy_list
copy

#rm albumlist.tmp copy_list.tmp
exit 0
