#!/bin/bash
set -e

#--- Configuring git
git config --global user.name "$(whoami)@$(hostname)"
git config --global user.email "nicob8691@gmail.com"

#--- Creating and activating ssh key for @github.com
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
	ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)" -f "$SSH_KEY" -N ""
fi

#--- Prompting public key for adding it to github.com
echo "👉 Public key to add to GitHub:"
echo "--------------------------------"
cat "${SSH_KEY}.pub"
echo "--------------------------------"
read -p "Make sure you copied pub key to github.com authorised keys. Continue?" -n1 -s
echo

#--- Testing connection
echo "🔍 Testing SSH connection to GitHub..."
ssh -T git@github.com || {
    echo "❌ SSH connection to GitHub failed. Make sure the key is added and GitHub trusts it."
    exit 1
}

### END ###
