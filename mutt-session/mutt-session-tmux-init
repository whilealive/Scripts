#!/bin/bash
#------------------------------------------
# mutt-session-tmux-init
# by Bruno Bischofberger, 15.01.2014
#
# initializes a new tmux sesseion with mutt
# and mbsync-secure in seperate windows
#------------------------------------------

tmux new-session -d -n mail -s mail 'mutt'
tmux new-window -n mbsync-secure -t mail:1 'mbsync-secure'
tmux select-window -t mail:0
tmux -2 attach-session -t mail
