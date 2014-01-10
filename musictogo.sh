#!/bin/bash
# ==================================================================
# FILE     musictogo.sh
# MACHINE  laptop (?) --> where the ogg library is...
# INFO     randomly chooses albums from library and copies them to 
#          mobile player
# DEPENDS  "moreutils"
#
# DATE     10.01.2014
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
find . -type d -links 2 > albumlist.tmp  # search for directories without subdirectories
nl -w4 --number-separator=": " albumlist.tmp | sponge albumlist.tmp  # add line numbers

# randomly choose a new album from the list, and 
# check its size
max=`wc -l albumlist.tmp`
nextnumbr=`expr $RANDOM % $max`  # evtl innerhalb awk erzeugen, damit eine Linie weiter unten verwendet werden kann. (dort wo jetzt "20" steht)
nextalbum=`awk -F: '$1 ~ /^20$/ {print $2}' albumlist.tmp`  # suche nach genau "20" in erstem Feld. Wie Variable reinnehmen? Zahlen linksbündig ausrichten.
albumsize=`du --block-size=MB -s $nextalbum/`

unset nextnumbr
unset albumsize

rm albumlist.tmp
