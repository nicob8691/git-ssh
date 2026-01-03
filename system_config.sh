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
DIR="/home/git"
mkdir -p $DIR
chown root:gitusers $DIR
chmod 2770 $DIR
#sudo install -d -o root -g gitusers -m 770 $DIR

find $DIR -type f -exec chmod 0660 {} +
setfacl -R -m u::rwx,g::rwx,o::--- $DIR
setfacl -R -m m::rwx $DIR

find $DIR -type d -exec chmod 2770 {} +
setfacl -R -d -m g::rwx,o::--- $DIR
setfacl -R -d -m m::rwx $DIR



dnf install -y policycoreutils-python-utils
semanage fcontext -a -t git_repo_t "/home/git(/.*)?"
restorecon -R /home/git

#--- Configuring git
git config --system core.editor nano
git config --system core.fileMode true

### END ###
