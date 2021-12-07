#!/bin/bash
#
#
# Instructions:
#
# curl -sL https://raw.githubusercontent.com/ansible-used-roles/ansible-role-landir.tmux_vim/main/scripts/quickinstall.sh | sudo bash
#
#

set -x
set -e
PATH=/usr/local/bin:$PATH

if [[ -f /usr/bin/apt-get ]]
then
    sudo apt-get update
fi

if ! which git
then
  if [[ -f /usr/bin/apt-get ]]
  then
    sudo apt-get install -y git
  fi
  if [[ -f /bin/yum ]]
  then
    sudo yum install -y git
  fi
fi

if ! which ansible
then
  if [[ -f /usr/bin/apt-get ]]
  then
    sudo apt-get install -y python3-pip
    sudo pip3 install ansible ansible-lint yamllint
  fi
  if [[ -f /bin/yum ]]
  then
    . /etc/os-release
    sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-${VERSION_ID:0:1}.noarch.rpm || true
    sudo yum install -y python3-pip
    sudo pip3 install ansible
  fi
fi

sudo mkdir -p /etc/ansible/roles
sudo env PATH=$PATH ansible-pull -U https://github.com/ansible-used-roles/ansible-role-landir.tmux_vim -d /etc/ansible/roles/ansible-role-landir.tmux_vim -i scripts/localinventory default.yml
