#!/bin/bash

function install-sample() {
  echo -n "[Install sample] "
  docker-compose exec couchbase-1 sh -c 'curl -X POST -u "$USERNAME":"$PASSWORD" http://couchbase-1.local:8091/sampleBuckets/install -d '\''["travel-sample"]'\'''
  echo
}

function test-query() {
  echo "[Test query to $1]"
  docker-compose exec couchbase-1 sh -c 'cbq -t="60s" -q -u "$USERNAME" -p "$PASSWORD" -e '"$1"' --script "SELECT COUNT(*) FROM \`travel-sample\`.inventory.airline"'
}

function container-stop() {
  echo "[Stop container $1]"
  docker-compose kill "$1" -s SIGKILL
  docker-compose stop "$1"
}

function container-up() {
  echo "[Up container $1]"
  docker-compose up -d "$1"
}

function rebalance() {
  echo -n "[Rebalance cluster $1] "
  docker-compose exec couchbase-1 sh -c 'couchbase-cli rebalance --cluster '"$1"' --username "$USERNAME" --password "$PASSWORD"'
}

function failover() {
  echo -n "[Failover cluster $1] "
  docker-compose exec couchbase-1 sh -c 'couchbase-cli failover --cluster '"$1"' --server-failover '"$2"' --username "$USERNAME" --password "$PASSWORD"'
}

install-sample

rebalance couchbase-1.local

test-query couchbase-1.local
test-query couchbase-2.local
test-query couchbase-3.local
test-query couchbase-4.local
test-query couchbase-5.local
test-query couchbase-6.local

container-stop couchbase-3

test-query couchbase-1.local
test-query couchbase-2.local
test-query couchbase-4.local
test-query couchbase-5.local
test-query couchbase-6.local

container-stop couchbase-2

test-query couchbase-1.local
test-query couchbase-4.local
test-query couchbase-5.local
test-query couchbase-6.local

container-stop couchbase-4

test-query couchbase-1.local
test-query couchbase-5.local
test-query couchbase-6.local

container-stop couchbase-6

test-query couchbase-1.local
test-query couchbase-5.local

container-stop couchbase-5

container-up couchbase-5

test-query couchbase-1.local
