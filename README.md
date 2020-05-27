# Objective
Personal automation for raspberry pi kubernetes cluster and pi hole boxes.

# Directory Layout
* k3s - directory for k3s deployment apps
* scripts - scripts for installing and bootstraping things using ansible adhoc script execution
* configs - cloud-init configs for bootstraping images on raspberry (not currently used)

# k3s cluster
https://blog.alexellis.io/test-drive-k3s-on-raspberry-pi/

## Installing workers
export K3S_TOKEN=$TOKEN
ansible workers -i inv.ini -b -m script -a "scripts/k3s/install_k3s_worker.sh ${K3S_TOKEN}"


