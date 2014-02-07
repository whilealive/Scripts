#!/bin/bash
# ==================================================================
# FILE     pullhemall.sh
# MACHINE  all
# INFO     pulls all my git repositories at once
#
# DATE     07.02.2014
# OWNER    Bischofberger
# ==================================================================

# my github repositories
declare -a Repo=(
    "$HOME/Dotfiles/" \
    "$HOME/Build/"\
)

die(){
    echo -e "$0: Error: $1" >&2
    exit 1
}

for path in "${Repo[@]}" ; do
    cd $path
    pwd
    git pull origin master || die "Could not pull."
done

cd $Home
exit 0
