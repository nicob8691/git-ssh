# git-ssh

### SERVER
Check out ip address & sshkey fingerprint on ssh server
```bash
ip a
sudo ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub
```

### CLIENT
Remove older ssh fingerprint, then connect to server through ssh
```bash
ssh-keygen -R [ip]
ssh root@[ip]
```

## Initialisation
Install git and clone git-ssh repo
```bash
dnf install -y git
git clone https://github.com/nicob8691/git-ssh.git
cd git-ssh
```

## Configuration
Configure /home/git dir and ssh token
```bash
. system_config.sh
. user_config.sh
```

## Clone repos
```bash
. clone.sh [REPONAME]
```
