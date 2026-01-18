#!/bin/bash
set -euo pipefail
[ "$EUID" -eq 0 ] || { echo "This script must be run as root"; exit 1; }

for repo in "$@"; do
FOLDER="/home/git/$repo"

	#--- Skip if already cloned -------------------------------------------
	if [ -d "$FOLDER/.git" ]; then
		echo "$repo already cloned. Skipping."
		continue
	fi

	#--- Create repo dir & clone repo -------------------------------------
	mkdir -p "$FOLDER"
	git clone "git@github.com:nicob8691/$repo.git" "$FOLDER"

	#--- Leave traceability of the git clone puller -----------------------
	echo "Git repo pulled by $(git config --get user.name)" >> "$FOLDER/OWNER"

	#--- Ensure OWNER file is ignored -------------------------------------
	grep -qx "OWNER" "$FOLDER/.gitignore" 2>/dev/null || \
		echo "OWNER" >> "$FOLDER/.gitignore"

	#--- Ownership --------------------------------------------------------
	chown -R root:gitusers "$FOLDER"

	#--- Allow git access
	git config --system --add safe.directory "$FOLDER"

done
### END ###
