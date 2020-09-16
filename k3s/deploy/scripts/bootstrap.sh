#!/bin/bash
set -e

export NODE_1="$(dig basil.home +short)"
export NODE_2="$(dig salt.home +short)"
export NODE_3="$(dig pepper.home +short)"
export USER=cbruner

# The first server starts the cluster
k3sup install \
  --ip $NODE_1 \
  --cluster \
  --user $USER

echo "Sleeping for 3 seconds..."
sleep 3

# The second node joins
k3sup join \
  --server \
  --ip $NODE_2 \
  --user $USER \
  --server-user $USER \
  --server-ip $NODE_1

echo "Sleeping for 3 seconds..."
sleep 3

# The third node joins
k3sup join \
  --server \
  --ip $NODE_3 \
  --user $USER \
  --server-user $USER \
  --server-ip $NODE_1
