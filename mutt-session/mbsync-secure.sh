#!/bin/bash
# ==================================================================
# FILE     mbsync-secure
# MACHINE  all
# INFO     runs mbsync periodically with gpg security
#
# DATE     25.01.2014
# OWNER    Bischofberger
# ==================================================================

# TODO:


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
	echo "running mbsync..."

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
	echo -e "uzh new:\t $NEW2"
	echo -e "zhaw new:\t $NEW3"

	# some information
	echo -n -e "\nlast sync: "
	date --utc +"%H:%M"
	echo "next sync in $period minutes."

	# either wait for 15 minutes or check again immediately by pressing Enter
	echo -e "to sync mails now, press [Enter]\n"
	read -s -t $period_sec input
done
