#!/bin/bash
# ==================================================================
# FILE     musictogo.sh
# MACHINE  laptop (?) --> where the ogg library is...
# INFO     randomly chooses albums from library and copies them to 
#          mobile player
#
# DATE     05.02.2014
# OWNER    Bischofberger
# ==================================================================

# TODO  - Check all exit status stuff
#       - implement option -n


# paths
library="$HOME/Music/mp3-snapshot"
#library="$HOME/Music"
player="/run/media/$(hostname)/syncstick"  # path after mounting


die(){
    echo -e "$0: Error: $1" >&2
    exit 1
}

# explains usage when giving the "--help" option
usage() {
    echo -e "usage: $0 [OPTION]\n\
Copies whole albums from your local music library to an external player/SD card.\n\

-k, --keep-logs       do not remove temporary files (such as albumlist and copylist)
-n, --number [NUMBR]  give a maximal number of albums to be exchanged through a random selection
    --help            shows this help
    --version         shows version number
"
    exit 0
}

# handle options
while [ -n "$1" ]; do
    case "$1" in
        "--help")
            usage
            ;;
        "--version")
            echo "musictogo Version 0.1"
            exit 0
            ;;
        "-k" | "--keep-logs")
            keep=1
            shift
            ;;
        "-n"|"--number")
            shift
            exchange_nmbr=$1
            if [[ ! $exchange_nmbr =~ ^[0-9]+$  || $exchange_nmbr == 0 ]] ; then
                die "Give a number > 1."
            fi
            shift
            ;;
        *)
            die "Unknown parameter '$1'.\nGet further information with the \"--help\" option."
            ;;
    esac
done

# delete all content on player
delete_all() {
    if [ -e $player ] ; then
        echo -n "Do you really want to delete ALL content on $player? (y/n) "
        read answer

        if [[ $answer == y ]] ; then
            rm -r $player/* || die "Could not delete content."
            echo -e "Successfully deleted all content.\n"
        elif [[ $answer == n ]] ; then
            echo -e "No changes on $player.\n"
        else
            die "Invalid answer."
        fi
    else
        die "Please plug in player/card and rerun programme."
    fi
}

# check free space on player
# variables set: $free_space
check_free_space() {
    if [ -e $player ] ; then
        echo -n "Checking free space on $player..."

        free_space=`df --block-size=1K $player | awk -F'[^0-9]*' 'NR==2 {print $5}'`
        local info_space=`expr $free_space / 1024`

        echo "done."
        echo -e "You have approximately $info_space MB free space on $player.\n"
        echo -n "Would you like to proceed? (y/n) "
        read answer

        if [[ $answer == n ]]  ; then
            exit 1
        fi
        echo ""
    else
        die "Please plug in player/card and rerun programme."
    fi
}

# list all albums in a temporary file called "albumlist.tmp"
list_albums() {
    if [ -e albumlist.tmp ] ; then
        mv albumlist.tmp albumlist_old.tmp
    fi

    echo -n "Collecting music library information..."

    touch albumlist.tmp albumlist2.tmp
    find . -type d -links 2 > albumlist2.tmp  # search for directories which have no more subdirectories
    awk '{ printf("%d\t%s\n", NR, $0) }' albumlist2.tmp > albumlist.tmp  # add line numbers
    max=`wc -l < albumlist.tmp`  # upper bound for random number generator in rand_choose()
    rm albumlist2.tmp

    echo -e "done.\n"
}

# randomly choose a new album from the list, and check its size
# variables set: $nextalbum, $albumsize, $nextnumbr
rand_choose() {
    local FLOOR=1
    nextnumbr=`expr $RANDOM % $max`
    while [ $nextnumbr -lt $FLOOR ] ; do
        nextnumbr=`expr $RANDOM % $max`
    done
    nextalbum=`awk -F '\t' '$1 ~ /^'$nextnumbr'$/ {print $2}' albumlist.tmp`
    albumsize=`du --block-size=1K -s "$nextalbum" | cut -f1 | grep -o '[0-9]\+'`
}

# randomly choose albums until space is full
create_copy_list() {
    if [ -e copy_list.tmp ] ; then
        mv copy_list.tmp copy_list_old.tmp
    fi

    echo -n "Randomly choosing albums..."

    local size_sum=0
    local again="yes"
    local chosen[0]=0  # list of already chosen numbers

    touch copy_list.tmp
    while (( size_sum < free_space )) ; do
        rand_choose
        while [[ $again == yes ]] ; do
            again="no"
            for i in ${chosen[@]} ; do
                if (( nextnumbr == i )) ; then  # random number appears twice
                    rand_choose
                    again="yes"
                fi
            done
        done
        chosen=(${chosen[@]} $nextnumbr)
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

    while read line ; do
        cp -r --parents "$line" $player/ || die "Could not copy all content."
    done < copy_list.tmp

    echo "done."
    local num=`wc -l < copy_list.tmp`
    echo "$num albums have been copied."
}
    


### main script starts here ###
cd $library || die "Directory $library not available on this system."
delete_all
check_free_space
list_albums
create_copy_list
copy

# handle logfiles
if [ ! -v keep ] ; then
    rm albumlist.tmp copy_list.tmp
else
    echo "Logfiles can be found in $library."
fi

echo -e "\nEnjoy!"

exit 0
