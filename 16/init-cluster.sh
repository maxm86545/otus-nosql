#!/bin/bash

set -e

CLUSTER_NAME='my'
NODE1='manticore1'
NODE2='manticore2'
NODE3='manticore3'

echo "[START NODES]"
docker-compose up -d

echo "[CREATE CLUSTER]"
docker-compose exec $NODE1 mysql -e  "CREATE CLUSTER ${CLUSTER_NAME}"
docker-compose exec $NODE2 mysql -e  "JOIN CLUSTER ${CLUSTER_NAME} AT '${NODE1}:9312'"
docker-compose exec $NODE3 mysql -e  "JOIN CLUSTER ${CLUSTER_NAME} AT '${NODE1}:9312'"
docker-compose exec $NODE3 mysql -e  "ALTER CLUSTER ${CLUSTER_NAME} UPDATE nodes"
docker-compose exec $NODE2 mysql -e  "SHOW STATUS LIKE 'cluster_${CLUSTER_NAME}_node%'"

echo "[CREATE DISTRIBUTED INDEX]"
docker-compose exec $NODE2 mysql -e  "CREATE TABLE test (test text)"
docker-compose exec $NODE2 mysql -e  "INSERT INTO test VALUES(1, 'test1'), (2, 'test2')"
docker-compose exec $NODE2 mysql -e  "ALTER CLUSTER ${CLUSTER_NAME} ADD test"

echo "[GET DATA]"
docker-compose exec $NODE1 mysql -e  "SELECT * FROM test"
docker-compose exec $NODE3 mysql -e  "SELECT * FROM test"
