#!/bin/bash
# ==================================================================
# FILE     dwm-statusbar-desktop.sh
# MACHINE  desktop
# INFO     Status script for dwm, light desktop version
#
# DATE     17.12.2013
# OWNER    Bischofberger
# ==================================================================


vol(){
	vol="$(awk '/%/ {gsub(/[\[\]]/,""); print $4}' <(amixer get Master))"
	on_off="$(awk '/%/ {gsub(/[\[\]]/,""); print $6}' <(amixer get Master))"
	if [ $on_off == on ]; then
	  echo "VOL $vol"
	else
	  echo "MUTE"
	fi
}

dte(){
	date --utc +"%d.%b %Y - %H:%M"
}

# Pipe to status bar
xsetroot -name "$(dte) Uhr "
#xsetroot -name "[$(vol)] $(dte) Uhr "
