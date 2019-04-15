# Scripts

Some shell scripts

#### emailsession/
- folder consists of some bash scripts to start a mutt/mbsync session with gpg key security in a tmux window

#### pcsync
- rsync script for synchronizing my machines through an USB stick

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

#### pdfTojpg
- convert multiple page pdf file to jpg's

#### trash
- ~/.trash/ folder support

#### vol
- volume handling with pulseaudio

#### pushemall/statemall
- push to or get status of all my repos at github at once

#### snippy
- see: [https://bbs.archlinux.org/](https://bbs.archlinux.org/viewtopic.php?id=71938&p=2)

#### f_diskscan
- search for mounted disks to choose from

#### f_tmux-helpers
- collection of tmux helper functions, e.g.
  - send message to all clients
  - (...)

#### musicsync/
- sync my volumio instances
- sync SD cards for my mobile player

#### screenshot
- uses imagemagick to capture screenshots

#### backup
- just some rsnapshot wrapper

#### downsizeAlbumCovers
- downsize album covers to a volumio-suitable format

#### notesd
- handle text notes by dmenu and st

#### texsessioninit
- just some tmux command to open a latex session on a specific awesome-wm tag

### tikzextract
- extract all tikz environments in a .tex file and put it into a seperate compilable file
- compile the output file with latexmk
