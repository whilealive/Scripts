#!/bin/bash
# ==================================================================
# FILE     musictogo.sh
# MACHINE  laptop (?) --> where the ogg library is...
# INFO     randomly chooses albums from library and copies them to 
#          mobile player
# DEPENDS  "moreutils"
#
# DATE     24.01.2014
# OWNER    Bischofberger
# ==================================================================

# TODO 
# - 


# variables
library="$HOME/Music"
player="/run/media/$(hostname)/..."
limit=30*1024  # size of player = 30GB
sum=0


# Grösse des albums berechnen,
# wenn summe mit albumsize addiert grösser als limit, nicht hinzufügen
# mit Kopieren auf Player fortfahren


cd $library

# list all albums in a temporary file
touch albumlist.tmp
find . -type d -links 2 > albumlist.tmp                              # search for directories without subdirectories
nl -w4 --number-separator=": " albumlist.tmp | sponge albumlist.tmp  # add line numbers
awk '{$1=$1}1' albumlist.tmp | sponge albumlist.tmp                  # delete all leading spaces

# randomly choose a new album from the list, and check its size
max=`wc -l < albumlist.tmp`
nextnumbr=`expr $RANDOM % $max`
nextalbum=`awk -F:\  '$1 ~ /^'$nextnumbr'$/ {print $2}' albumlist.tmp`
albumsize=`du --block-size=MB -s "$nextalbum" | cut -f1`
echo $albumsize

#rm albumlist.tmp
