#!/bin/bash

function cluster-init() {
  echo -n "[Cluster $1 with $2 init] "
  couchbase-cli cluster-init \
    --cluster "$1" \
    --cluster-username "$USERNAME" \
    --cluster-password "$PASSWORD" \
    --cluster-ramsize 512 \
    --services "$2" \
    --update-notifications 1 \
    --ip-family ipv4-only \
    --node-to-node-encryption off
}

function server-add() {
  echo -n "[Server $2 with $3 add to cluster $1] "
  couchbase-cli server-add \
    --cluster "$1" \
    --username "$USERNAME" \
    --password "$PASSWORD" \
    --server-add "$2" \
    --server-add-username "$USERNAME" \
    --server-add-password "$PASSWORD" \
    --services "$3"
}

function rebalance() {
  echo -n "[Rebalance cluster $1] "
  couchbase-cli rebalance \
    --cluster "$1" \
    --username "$USERNAME" \
    --password "$PASSWORD" \
    --no-progress-bar
}

function server-list() {
  echo "[Server list for cluster $1]"
  couchbase-cli server-list \
    --cluster "$1" \
    --username "$USERNAME" \
    --password "$PASSWORD"
}

function setting-autofailover() {
  echo -n "[Setting autofailover for cluster $1] "
    couchbase-cli setting-autofailover \
    --cluster "$1" \
    --username "$USERNAME" \
    --password "$PASSWORD" \
    --enable-auto-failover "$2" \
    --auto-failover-timeout "$3" \
    --enable-failover-on-data-disk-issues 1 \
    --failover-data-disk-period 5 \
    --can-abort-rebalance 1 \
    --max-failovers "$4"
}

cluster-init couchbase-1.local data
setting-autofailover couchbase-1.local 1 5 3
server-add couchbase-1.local couchbase-2.local,couchbase-3.local data
server-add couchbase-1.local couchbase-4.local index
server-add couchbase-1.local couchbase-5.local query
server-add couchbase-1.local couchbase-6.local fts,eventing,analytics,backup
rebalance couchbase-1.local
server-list couchbase-1.local
