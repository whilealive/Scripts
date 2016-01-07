Scripts
=======

Some shell scripts

emailsession
------------
- consists of some bash scripts to start a mutt/mbsync session
  with gpg key security in a dvtm window

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

dwm-statusbar
-------------
- out of order --> see: dwmstatus in C
- bash version of my statusbar using xsetroot
- shows battery, volume and date

clipswap
--------
- swap PRIMARY and CLIPBOARD

pdfpextr
--------
- extract pages from pdf files

snippy
------
see: https://bbs.archlinux.org/viewtopic.php?id=71938&p=2

pushemall
------
push all my repos to github at once

musictogo
=========
take your music with you
- little program written in bash that randomly chooses 
  albums of your music library and copies them to an 
  SD-card which goes into your phone or player.
- always copies whole albums either until card is full
  or up to a maximal number of albums to be replaced
- can also distribute music to more than one disk
- sync option: "pseudo sync" of music library to more 
  than one SD-card, mounting one after another
- check musictogo --help for further details
