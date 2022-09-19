#!/bin/bash

set -e

CLUSTER_NAME='my'
NODE1='manticore1'
NODE2='manticore2'
NODE3='manticore3'

echo "[STOP NODE1]"
docker-compose stop $NODE1

echo "[INSERT DATA]"
docker-compose exec $NODE2 mysql -e  "INSERT INTO ${CLUSTER_NAME}:test VALUES(3, 'test3'), (4, 'test4')"
docker-compose exec $NODE3 mysql -e  "INSERT INTO ${CLUSTER_NAME}:test VALUES(5, 'test5')"

echo "[START NODE1]"
docker-compose up -d $NODE1

echo "[GET DATA FROM NODE1]"
sleep 1
docker-compose exec $NODE1 mysql -e  "SELECT * FROM ${CLUSTER_NAME}:test"
