# git-ssh
Automated script for connecting and cloning git

### Initialisation
Install git and clone git-ssh repo
```bash
dnf install -y git
git clone https://github.com/nicob8691/git-ssh.git
cd git-ssh
```

### Configuration
Configure /home/git dir and ssh token
```bash
. system_config.sh
. user_config.sh
```

### Clone repos
```bash
. clone.sh [REPONAME]
```
