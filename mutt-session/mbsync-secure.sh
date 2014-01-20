#!/bin/bash
#------------------------------------------
# mbsync-secure
# by Bruno Bischofberger, 17.01.2014
# runs mbsync periodicly with gpg security
#------------------------------------------

# TODO:
# use "sponge" from "moreutils" ?
# title change
# give a total of new messages at the bottom


# variables
period="10"
let "period_sec = 60 * $period"

INBOX1=$HOME/Maildir/fastmail/INBOX/new/
INBOX2=$HOME/Maildir/uzh-pseudo/INBOX_uzh/new/
INBOX3=$HOME/Maildir/zhaw-pseudo/INBOX_zhaw/new/

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

	# run mbsync using the temporary rc file and delete it aftwerwards
	mbsync -q -c ~/.mbsyncrc-temp -a
	shred -xu ~/.mbsyncrc-temp1 ~/.mbsyncrc-temp2 ~/.mbsyncrc-temp

	# count new messages
	NEW1=`find $INBOX1 -type f | wc -l`
	NEW2=`find $INBOX2 -type f | wc -l`
	NEW3=`find $INBOX3 -type f | wc -l`
	echo -e "fastmail new:\t $NEW1"
	echo -e "uzh new:\t $NEW1"
	echo -e "zhaw new:\t $NEW1"

	# some information
	echo -n -e "\nlast sync: "
	date --utc +"%H:%M"
	echo "next sync in $period minutes."

	# either wait for 15 minutes or check again immediately by pressing Enter
	echo "to sync mails now, press [Enter]"
	read -s -t $period_sec input
done
