#!/bin/bash

SALT_REPO="https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm"
INSTALL_PKGS="git salt-minion"
SALT_MINION="salt-minion"

function install_salt_minion() {
    yum install -y $SALT_REPO && yum install -y $INSTALL_PKGS
    echo "Master/Minion installed successfully."
    systemctl start $SALT_MINION && systemctl enable $SALT_MINION
    echo "Minion started and enabled successfully."
}

function bootstrap_salt() {
    # Install minion by default, but also install master if master str is passed.
    if [[ $1 == "master" ]]; then
        mkdir -p /srv/salt/
        formula_location="/srv/salt/base"
        pillar='{"is_saltmaster": True}'
    else
        formula_location="/tmp/salt-formulas"
        pillar='{}'
    fi

    if [[ -d ${formula_location} ]]; then
        echo "Updating ${formula_location}"
        cd ${formula_location} && git pull origin master
    else
        echo "Cloning colinbruner/salt-formulas -> ${formula_location}"
        git clone https://github.com/colinbruner/salt-formulas.git ${formula_location}
    fi

    salt-call --file-root=/tmp/salt-formulas --local state.apply bootstrap pillar=$pillar
}

if [[ $USER != "root" ]]; then
    echo "Requires root permissions to run. Run this again with sudo, or as root."
    exit 1
fi

install_salt_minion
bootstrap_salt $1
