#!/bin/bash

set -e

KEYS=10
NODES=3
FAILURE_TOLERANCE=$((NODES - (NODES / 2 + 1)))

function consul() {
  echo "[NODE${1}] consul ${2}"
  docker-compose exec "consul-${1}" sh -c "consul ${2}"
  echo
}

function stop-node() {
  echo "[NODE${1}] STOP"
  docker-compose stop "consul-${1}"
  echo
}

echo "[KEYS = ${KEYS}][NODES = ${NODES}][FAILURE TOLERANCE = ${FAILURE_TOLERANCE}]"
echo

consul $((1 % NODES)) 'members'

consul $((2 % NODES)) 'kv delete test/'

i=0
while [ $i -lt "$KEYS" ]; do
  consul $((i % NODES + 1)) "kv put test/key${i} value${i}"
  i=$((i + 1))
done

NODE=1
while [ $NODE -le "$FAILURE_TOLERANCE" ]; do
  consul $NODE "kv get -recurse"
  stop-node $NODE
  NODE=$((NODE + 1))
done

consul $NODES "kv get -recurse"

stop-node $NODE

consul $NODES "kv get -recurse"
