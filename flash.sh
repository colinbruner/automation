#!/bin/bash

CONFIG_DIR="configs/flash"
HOSTS="pihole" # pihole raspberry pi flashing
#HOSTS="node01 node02 node03 node04 node05" # kubernetes worker nodes

FLASH=$(which flash)
if [[ $? != 0 ]]; then
    echo "Please ensure 'flash' is installed and executable within your PATH."
    exit 1
fi

if [[ ! -z $1 ]]; then
    IMAGE=$1
    for host in $HOSTS; do
        echo "Flashing $host."
        $FLASH -u "$CONFIG_DIR/${host}.yml" $IMAGE
        read -p "Flash Complete. Continue? " ans
        case $ans in
            [Yy]* ) continue;;
            [Nn]* ) exit 2;;
            * ) echo "Please answer 'yes' or 'no'.";;
        esac
    done
    exit 0
else
    echo "Please specify image to flash."
    exit 2
fi
