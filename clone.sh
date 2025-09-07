#!/bin/bash
set -e

for repo in "$@"; do

	#--- Set repo dir variable
	FOLDER="/home/git/$repo"

	#--- Skip if already a valid Git repo
	if git -C "$FOLDER" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
		echo "$repo already cloned. Skipping."
		continue
	fi

	#--- Create repo dir
	install -d -o "$(whoami)" -g gitusers -m 770 "$FOLDER"

	#--- Clone repo
	git clone "git@github.com:nicob8691/$repo.git" "$FOLDER"

	#--- Leave traceability of the git clone puller
	echo "Git repo pulled by $(git config --get user.name)" > "$FOLDER/OWNER"

	#--- Add OWNER to .gitignore if it doesn't exist
	if [ ! -f "$FOLDER/.gitignore" ]; then
		echo "OWNER" > "$FOLDER/.gitignore"
	fi

	#--- Ensure ownership and file modes
	chgrp -R gitusers "$FOLDER"
	chmod -R 770 "$FOLDER"
	[ -f "$FOLDER/LICENSE" ] && chmod 440 "$FOLDER/LICENSE"
	[ -f "$FOLDER/OWNER" ] && chmod 440 "$FOLDER/OWNER"

	#--- Allow global git access to this directory
	git config --global --add safe.directory "$FOLDER"

done

### END ###

