#!/bin/bash
#------------------------------------------
# mbsync-secure
# by Bruno Bischofberger, 10.01.2014
# runs mbsync periodicly with gpg security
#------------------------------------------

# TODO:
# use "sponge" from "moreutils"
# title change


# variables
period="15"
let "period_sec = 60 * $period"

passwd1="$(gpg2 -dq ~/.my-pwds.gpg | cut -c 40- | sed -n 1p)"
passwd3="$(gpg2 -dq ~/.my-pwds.gpg | cut -c 40- | sed -n 3p)"
passwd2="$(gpg2 -dq ~/.my-pwds.gpg | cut -c 40- | sed -n 4p)"


while true
do
	# copy password into a temporary rc file.
	# the right position in the rc file is crucial and marked in the original file by the line '#Pass1' etc.
	sed s/\#Pass1/Pass\ $passwd1/ ~/.mbsyncrc > ~/.mbsyncrc-temp1
	sed s/\#Pass3/Pass\ $passwd3/ ~/.mbsyncrc-temp1 > ~/.mbsyncrc-temp2
	sed s/\#Pass2/Pass\ $passwd2/ ~/.mbsyncrc-temp2 > ~/.mbsyncrc-temp

	# run mbsync using the temporary rc file
	mbsync -c ~/.mbsyncrc-temp -a
	echo -n -e "\nlast sync: "
	date --utc +"%H:%M"
	echo "next sync in $period minutes."

	# delete the insecure copy of the rc file again
	shred -xu ~/.mbsyncrc-temp1 ~/.mbsyncrc-temp2 ~/.mbsyncrc-temp

	# either wait for 15 minutes or check again immediately by pressing Enter
	echo "to sync mails now, press [Enter]"
	read -s -t $period_sec input
done
