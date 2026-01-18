#!/bin/bash
set -euo pipefail
if [ "$EUID" -ne 0 ]; then echo "This script shall be run by root."; exit 1; fi

#--- Create gitusers group ----------------------------------------------------
getent group gitusers >/dev/null || groupadd -g 1002 gitusers
usermod -aG gitusers $(id -nu 1000)

#--- Configure local repo /home/git -------------------------------------------
DIR="/home/git"
mkdir -p $DIR
chown root:gitusers $DIR
chmod 2770 $DIR

#--- Configure ACL ------------------------------------------------------------
dnf install -y acl
find $DIR -type f -exec chmod 0660 {} +
setfacl -R -m u::rwx,g::rwx,o::--- $DIR
setfacl -R -m m::rwx $DIR
find $DIR -type d -exec chmod 2770 {} +
setfacl -R -d -m u::rwx,g::rwx,o::--- $DIR
setfacl -R -d -m m::rwx $DIR

#--- Configure SELinux context & policy ---------------------------------------
dnf install -y policycoreutils-python-utils
semanage fcontext -a -t user_home_t "/home/git(/.*)?" 2>/dev/null \
	|| semanage fcontext -m -t user_home_t "/home/git(/.*)?"
restorecon -R /home/git

#--- Configuring git ----------------------------------------------------------
git config --system core.editor nano
git config --system core.fileMode true

### END ###
