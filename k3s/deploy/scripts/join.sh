#!/bin/bash
NODE_1=$(dig node1.home +short)
NODE_2=$(dig node2.home +short)
NODE_3=$(dig node3.home +short)
NODE_4=$(dig node4.home +short)
NODES=(${NODE_1} ${NODE_2} ${NODE_3} ${NODE_4})

export USER=cbruner
export SERVER_IP=$(dig basil.home +short)

for node in ${NODES[@]}; do
        k3sup join \
          --ip $node \
          --user $USER \
          --server-user $USER \
          --server-ip $SERVER_IP \
          --server
done
