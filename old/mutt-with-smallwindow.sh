#!/bin/bash

# ------------------------------------
# opens mutt and a small comand window
# Bruno Bischofberger, 09.04.2013
# ------------------------------------

# small command window
urxvtc -title smallterm -geometry 39x19+1000+0 &

# additional window for mbsync-auto script running
urxvtc -title mbsync -geometry 39x24+1000+350 &

# open mutt
urxvtc -geometry 110x43 -e mutt &
