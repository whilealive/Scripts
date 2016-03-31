# Scripts

Some shell scripts

#### emailsession/
- folder consists of some bash scripts to start a mutt/mbsync session with gpg key security in a tmux window

#### pcsync
- rsync script for synchronizing my machines through an USB stick

#### zathuratab
- open pdfs in zathura within tabbed (suckless)

#### beamer
- tries to handle multi-monitor setup (mirror) with dwm through xrandr
- Possible setups 
  1. *there exists a common (and reasonnably high) resolution between external and laptop monitor*<br>
  this is being handled well without further tweaking by dwm [suckless.org/multi-monitor](http://dwm.suckless.org/multi-monitor)
  2. *external resolution is higher (in x and y) than laptop screen*<br>
  only acceptable way I know of by now is the xrandr "panning" mode which works quite nicely. However, there seems to be a bug [Bug #1326688](https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/1326688) which prevents from getting out of panning mode. Therefore we must quit dwm (which quits xserver) and restart it with startx.
  3. *external resolution is smaller (in x or y) than laptop screen*<br>
  hasn't happened yet, no solution yet.
- type `beamer --help` to get all the options

#### albumartinflac
- includes albumart in .flac files
- uses "metaflac" program
- How it works:
  1. save album cover as "cover.jpg" in album folder
  2. run: albumartinflac /path/to/album/

#### clipswap
- swap PRIMARY and CLIPBOARD

#### pdfpextr
- extract pages from pdf files

#### pdfpsize
- get page size of pdfs in mm

#### trash
- ~/.trash/ folder support

#### vol
- volume handling

#### pushemall/statemall
- push to or get status of all my repos at github at once

#### snippy
- see: [https://bbs.archlinux.org/](https://bbs.archlinux.org/viewtopic.php?id=71938&p=2)

#### tmux-helpers
- collection of tmux helper functions, e.g.
  - send message to all clients
  - (...)

#### musictogo/
- randomly chooses albums of your music library and copies them to an SD-card which goes into your phone or player.
- always copies whole albums either until card is full or up to a maximal number of albums to be replaced
- can also distribute music to more than one disk
- sync option: "pseudo sync" of music library to more than one SD-card, mounting one after another
- check `musictogo --help` for further details

#### vimserv
- start a vimserver with "vimserv" command (no argument)
- to open files in that server, use "vimserv $file"
- I use that to open text files from ranger in a unique vim server so that I have only one vim session running (copy/yank etc.)
- Just modify this line in ranger's rifle.conf: `mime ^text,  label editor = "vimserv" -- "$@"`

#### dwm-statusbar
- deprecated, see: dwmstatus in C
- bash version of my statusbar using xsetroot
- shows battery, volume and date
