#!/bin/bash
# ==================================================================
# FILE     pcsync.sh
# MACHINE  all
# INFO     syncs stuff from external HD to local HD and back, 
#          using rsync
#          - USB stick in ext4-format needs user rights after 
#            formatting: cd /run/media/, login as root with su, 
#            chown -R bruno:users bruno
#
# DATE     03.02.2014
# OWNER    Bischofberger
# ==================================================================

# TODO 
# - SSH Option für direktes synchronisieren über Heimnetzwerk


# variables
stick="/run/media/$(hostname)/syncstick/home/syncfolder"
includefile="$HOME/Scripts/pcsync-inclexcl.txt"
dry=""


# helper functions
die(){
    echo "$0: Error: $1" >&2
    exit 1
}

# just a message
nothing_done(){
    echo -e "\nEither answered \"no\" or invalid input."
    echo "Nothing will be done."
}


# handle options
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

# better ask twice...
echo -n "Syncup (up) or Syncdown (down)? "
read answer

if [[ $answer == up ]] ; then
    echo -n "Do you really want to sync local data to EXTERNAL disk? (y/n) "
	read answer2

	if [[ $answer2 == y ]] ; then
		if [[ $dry != "-n" ]] ; then  # handle dry-run option
			echo "setting correct rights on $stick"
			sudo chown -R $(hostname):users $stick  # user handling for rsync --delete
		fi
		rsync -avu "$dry" --delete --include-from="$includefile" $HOME/ $stick/ \
            || die "rsync error"
		echo -e "\npcsync (up) successful"
	else
		nothing_done
	fi

elif [[ $answer == down ]] ; then
    echo -n "Do you really want to sync external disk to this LOCAL disk? (y/n) "
	read answer2

	if [[ $answer2 == y ]] ; then
		if [[ $dry != "-n" ]] ; then
			echo "setting correct rights on $stick"
			sudo chown -R $(hostname):users $stick
		fi
		rsync -avu "$dry" --delete --include-from="$includefile" $stick/ $HOME/ \
            || die "rsync error"
		echo -e "\npcsync (down) successful"
	else
		nothing_done
	fi

else
	nothing_done
fi
