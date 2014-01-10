#!/bin/bash
# ==================================================================
# FILE     pcsync.sh
# MACHINE  all
# INFO     syncs stuff from external HD to local HD and back, using
#          rsync
#
# DATE     10.01.2014
# OWNER    Bischofberger
# ==================================================================

# TODO 
# - Code in Englisch
# - Code sauberer machen
# - SSH Option für direktes synchronisieren über Heimnetzwerk


# variables
stick="/run/media/$(hostname)/syncstick/home/syncfolder"
includefile="$HOME/Scripts/pcsync/include-exclude-file"
dry=""

# helper functions
die(){
    echo "$0: Error: $1" >&2
    exit 1
}

nothing_done(){
	echo -e "\nEntweder mit \"nein\" geantwortet, oder ungültige Eingabe." 
	echo "Es wird nichts gemacht."
}


# info: rsync mit flag -n macht noch nichts, DRY RUN.
while [ -n "$1" ]; do
	case "$1" in
	"-n"|"--dry-run")
		dry="-n"
		shift;;
	*)
		echo "usage: $0 [-n|--dry-run]"
		die "unknown parameter '$1'"
		;;
	esac
done

# Frag lieber zweimal...
echo -n "Syncup (up) or Syncdown (down)? "
read answer

if [[ $answer == up ]] ; then
	echo -n "Lokale Daten wirklich auf EXTERNE HD synchronizieren? (j/n) "
	read answer2

	if [[ $answer2 == j ]] ; then
		if [[ $dry != "-n" ]] ; then  # dry-run Option behandeln
			echo "setting correct rights on $stick"
			sudo chown -R $(hostname):users $stick  # user anpassen für --delete Option
		fi

		rsync -avu "$dry" --delete --include-from="$includefile" $HOME/ $stick/
		echo "pcsync (up) successful"
	else
		nothing_done
	fi

elif [[ $answer == down ]] ; then
	echo -n "Externe Daten wirklich auf diese LOKALE HD synchronisieren? (j/n) "
	read answer2

	if [[ $answer2 == j ]] ; then
		if [[ $dry != "-n" ]] ; then
			echo "setting correct rights on $stick"
			sudo chown -R $(hostname):users $stick
		fi

		rsync -avu "$dry" --delete --include-from="$includefile" $stick/ $HOME/ 
		echo "pcsync (down) successful"
	else
		nothing_done
	fi

else
	nothing_done
fi
