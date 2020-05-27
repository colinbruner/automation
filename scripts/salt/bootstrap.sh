#!/bin/bash

function install_salt_minion_raspbian() {
    REPO="deb http://archive.raspbian.org/raspbian/ stretch main"
    if [[ ! $(grep "$REPO" /etc/apt/sources.list) ]]; then
        echo "$REPO" >> /etc/apt/sources.list
    fi
    apt-get update -y
    apt-get install -y salt-common/stable salt-minion/stable

}

function install_salt_minion_ubuntu() {
    PUBKEY="https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub"
    wget -O - $PUBKEY | apt-key add -
    REPO="deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main"

    if [[ ! $(grep "$REPO" /etc/apt/sources.list) ]]; then
        echo "$REPO" >> /etc/apt/sources.list
    fi
    apt-get update -y
    apt-get install -y salt-minion
}

function install_salt_minion_centos() {
    SALT_REPO="https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm"
    INSTALL_PKGS="git salt-minion"
    SALT_MINION="salt-minion"

    echo "Installing Master/Minion..."
    yum install -y $SALT_REPO && yum install -y $INSTALL_PKGS
    echo "Master/Minion installed successfully."
    systemctl start $SALT_MINION && systemctl enable $SALT_MINION
    echo "Minion started and enabled successfully."

}

function install_salt_minion() {
    if [[ $(uname) == "Linux" ]]; then
        distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
        if [[ $distro =~ "CentOS"* ]]; then
            # Install Salt on CentOS
            install_salt_minion_centos
        elif [[ $distro =~ "Raspbian"* ]]; then
            # Install Salt on Raspberry Pi's
            install_salt_minion_raspbian
        elif [[ $distro =~ "Ubuntu" ]]; then
            # Install Salt on Ubuntu
            install_salt_minion_ubuntu
        fi
    fi
}

if [[ $USER != "root" ]]; then
    echo "Requires root permissions to run. Run this again with sudo, or as root."
    exit 1
fi

install_salt_minion
