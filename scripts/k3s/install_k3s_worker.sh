#!/bin/bash

export K3S_URL="https://kube1.home:6443"
export K3S_TOKEN="${1}"

if [[ ! $1 ]]; then
  echo "Enter token and try again."
  exit 1
fi

echo "Installing k3s binary, start service, join master."
curl -sfL https://get.k3s.io | sh -
