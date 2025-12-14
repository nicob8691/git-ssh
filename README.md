# git-ssh
Automated script for connecting and cloning git

### Connect from distant client
| Client                        | Server                                                    |
| sudo nmap -sn 192.168.88.0/24 | sudo ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub   |
| ssh root@192.168.88.[*]       |                                                           |

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
