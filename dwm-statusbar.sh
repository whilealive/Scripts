#!/bin/bash
# ==================================================================
# FILE     dwm-statusbar.sh
# MACHINE  laptop
# INFO     Status script for dwm
#
# DATE     17.12.2013
# OWNER    Bischofberger
# ==================================================================


bat(){
  onl="$(grep "on-line" <(acpi -V))"
  charge="$(awk '{print +$4}' <(acpi -b))"
  if [[ ( -z $onl && $charge -gt 20 ) ]]; then 
      echo "BAT $charge%"
  elif [[ ( -z $onl && $charge -le 20 ) ]]; then
      echo "BAT $charge%"
  else
      echo "AC $charge%"
  fi
}

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
  date +"%d.%b %Y - %H:%M"
}

# Pipe to status bar
xsetroot -name "[$(bat)] [$(vol)] $(dte) Uhr "
