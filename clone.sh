#!/bin/bash
set -e

for repo in "$@"
do

	#--- Set repo dir variable
	FOLDER=/home/git/$repo

	#--- Check if git repo is already pulled
	if [ -d $FOLDER ]; then exit 1; fi

	#--- Create repo dir
	install -d -o $(whoami) -g gitusers -m 770 $FOLDER

	#--- Clone repo
	git clone git@github.com:nicob8691/$repo.git $FOLDER

	#--- Leave tracability of the git clone puller
	echo "Git repo pulled by $(git config get user.name)" > $FOLDER/OWNER
	if [ ! -f $FOLDER/.gitignore ]; then echo "OWNER" > $FOLDER/.gitignore; fi

	#--- Ensure ownership and filemodes
	chgrp -R gitusers $FOLDER
	chmod -R 770 $FOLDER
	if [ -f $FOLDER/LICENSE ]; then chmod 440 $FOLDER/LICENSE; fi
	if [ -f $FOLDER/OWNER ]; then chmod 440 $FOLDER/OWNER; fi

	#--- Enable repository to other users
	git config --global --add safe.directory $FOLDER

done

### END ###
