#!/bin/bash
#----------------------------------------------------------
# mutt-session
# by Bruno Bischofberger, 11.07.2013
# initializes mutt and mbsync in tmux
# with terminus font instead of standard font

# script copied to /usr/local/bin/
# obviously the script mbsync-secure is needed here
#----------------------------------------------------------

st -t mail -f -*-terminus-medium-r-*-*-16-*-*-*-*-*-*-* -e mutt-session-tmux-init
