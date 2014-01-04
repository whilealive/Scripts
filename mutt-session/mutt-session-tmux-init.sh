#!/bin/bash
#------------------------------------------
# mutt-session-tmux-init
# by Bruno Bischofberger, 04.01.2014
#
# initializes a new tmux sesseion with mutt
# and mbsync-secure in seperate windows
#------------------------------------------

#tmux new-session -d -s mail 'mbsync-secure'
#tmux new-window -n mutt -t mail:1
#tmux select-window -t mail:0
#tmux -2 attach-session -t mail

tmux new-session -d -n mail -s mail 
tmux new-window -n mbsync-secure -t mail:1 'mbsync-secure'
tmux select-window -t mail:0
tmux -2 attach-session -t mail
