#!/bin/bash
# ==================================================================
# FILE     musictogo.sh
# MACHINE  laptop (?) --> where the ogg library is...
# INFO     randomly chooses albums from library and copies them to 
#          mobile player
#
# DATE     08.01.2014
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
albumsize=`du --block-size=MB -s $album/`
