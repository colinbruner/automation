#!/bin/bash

SALT_REPO="https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm"
SALT_PKGS="salt-master salt-minion"
SALT_MINION="salt-minion"

function install_salt_minion() {
    yum install -y $SALT_REPO && yum install -y $SALT_PKGS
    echo "Master/Minion installed successfully."
    systemctl start $SALT_MINION && systemctl enable $SALT_MINION
    echo "Minion started and enabled successfully."
}

function bootstrap_salt() {
    git clone https://github.com/colinbruner/salt-formulas.git /tmp/salt-formulas
    # Bootstrap dotfiles and install necessary libraries for Saltmaster's GitFS
    salt-call --file-root=/tmp/salt-formulas --local state.apply /tmp/salt-formulas/bootstrap
}

if [[ $USER != 'root' ]]; then
    echo "Requires root permissions to run. Run this again with sudo, or as root."
    exit 1
fi

install_salt
bootstrap_salt
