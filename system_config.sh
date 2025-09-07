#!/bin/bash
set -e

#--- Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then echo "This script shall be run by root."; exit 1; fi

#--- Create gitusers group
if [ $(getent group | grep gitusers | wc -l) -eq 0 ]; then 
	groupadd -g 1002 gitusers
fi
usermod -aG gitusers $(id -nu 1000)

#--- Configure local repo /home/git
sudo install -d -o root -g gitusers -m 770 /home/git
semanage fcontext -a -t public_content_rw_t "/home/git(/.*)?"
restorecon -R /home/git

#--- Configuring git
git config --system core.editor nano
git config --system core.fileMode true

### END ###
