Scripts
=======

Some shell scripts

dwm-statusbar
-------------
- out of order --> see: dwmstatus in C
- bash version of my statusbar using xsetroot
- shows battery, volume and date

pcsync
------
- rsync script for synching my machines through an USB stick

zathuratab
----------
- open pdfs in zathura within tabbed (suckless)

vimserv
-------
- start a vimserver with "vimserv" command (no argument)
- to open files in that server, use "vimserv $file"
- I use that to open text files from ranger in a unique vim server
  so that I have only one vim session running (copy/yank etc.)
- Just modify this line in ranger's rifle.conf:
  mime ^text,  label editor = "vimserv" -- "$@"

albumartinflac
--------------
- includes albumart in .flac files
- uses "metaflac" program
- How it works:
  1.) save album cover as "cover.jpg" in album folder
  2.) run: albumartinflac /path/to/album/
