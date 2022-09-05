#!/bin/bash

set -e

echo "[CONFIGURE CONFIG SERVERS]"
docker-compose exec configsvr01 mongosh --quiet --eval "rs.initiate({
  _id: \"rs-config-server\",
  configsvr: true,
  version: 1,
  members: [
    {_id: 0, host: \"configsvr01\"},
    {_id: 1, host: \"configsvr02\"},
    {_id: 2, host: \"configsvr03\"}
 ]
})"

echo "[CONFIGURE SHARD01]"
docker-compose exec shard01-a mongosh --quiet --eval "rs.initiate({
  _id: \"rs-shard-01\",
  version: 1,
  members: [
    {_id: 0, host: \"shard01-a\"},
    {_id: 1, host: \"shard01-b\"},
    {_id: 2, host: \"shard01-c\"}
  ]
})"

echo "[CONFIGURE SHARD02]"
docker-compose exec shard02-a mongosh --quiet --eval "rs.initiate({
  _id: \"rs-shard-02\",
  version: 1,
  members: [
    {_id: 0, host: \"shard02-a\"},
    {_id: 1, host: \"shard02-b\"},
    {_id: 2, host: \"shard02-c\"}
  ]
})"

echo "[CONFIGURE ROUTERS]"
sleep 10

echo "[ADD SHARD01]"
docker-compose exec router01 mongosh --quiet --eval "
sh.addShard(\"rs-shard-01/shard01-a\")
sh.addShard(\"rs-shard-01/shard01-b\")
sh.addShard(\"rs-shard-01/shard01-c\")
"

echo "[ADD SHARD02]"
docker-compose exec router01 mongosh --quiet --eval "
sh.addShard(\"rs-shard-02/shard02-a\")
sh.addShard(\"rs-shard-02/shard02-b\")
sh.addShard(\"rs-shard-02/shard02-c\")
"

echo "[CREATE SHARD COLLECTION]"
docker-compose exec router01 mongosh --quiet --eval "
sh.enableSharding(\"test\")
db.createCollection(\"test1\")
db.test1.createIndex( { _id: \"hashed\" } )
sh.shardCollection(
  \"test.test1\",
  { _id: \"hashed\"}
)
db.createCollection(\"test2\")
sh.shardCollection(
  \"test.test2\",
  { _id: 1},
  true
)
"

echo "[INSERT DATA]"
docker-compose exec router01 mongosh --quiet --eval "
for (let i = 1; i <= 18; ++i) {
  db.test1.insertOne({ _id: i, t1field1: i, t1field2: i })
}
"
docker-compose exec router02 mongosh --quiet --eval "
for (let i = 1; i <= 18; ++i) {
  db.test2.insertOne({ _id: i, t2field1: i, t2field2: i })
}
"

echo "[CHECK DATA]"
docker-compose exec router02 mongosh --quiet --eval "db.test1.find().sort({ _id : 1 })"
docker-compose exec router02 mongosh --quiet --eval "db.test2.find().sort({ _id : 1 })"

echo "[CHECK DATA IN SHARD01]"
docker-compose exec shard01-a mongosh --quiet --eval "db.test1.find().sort({ _id : 1 })"
docker-compose exec shard01-a mongosh --quiet --eval "db.test2.find().sort({ _id : 1 })"

echo "[CHECK DATA IN SHARD02]"
docker-compose exec shard02-a mongosh --quiet --eval "db.test1.find().sort({ _id : 1 })"
docker-compose exec shard02-a mongosh --quiet --eval "db.test2.find().sort({ _id : 1 })"

echo "[STOP ROUTER01]"
docker-compose stop router01

echo "[STOP SHARD01-C]"
docker-compose stop shard01-c

echo "[STOP SHARD02-B]"
docker-compose stop shard02-b

echo "[CONFIGURE SHARD03]"
docker-compose exec shard03-a mongosh --quiet --eval "rs.initiate({
  _id: \"rs-shard-03\",
  version: 1,
  members: [
    {_id: 0, host: \"shard03-a\"},
    {_id: 1, host: \"shard03-b\"},
    {_id: 2, host: \"shard03-c\"}
  ]
})"

echo "[ADD SHARD03]"
docker-compose exec router02 mongosh --quiet --eval "
sh.addShard(\"rs-shard-03/shard03-a\")
sh.addShard(\"rs-shard-03/shard03-b\")
sh.addShard(\"rs-shard-03/shard03-c\")
"

echo "[CHECK DATA]"
docker-compose exec router02 mongosh --quiet --eval "db.test1.find().sort({ _id : 1 })"
docker-compose exec router02 mongosh --quiet --eval "db.test2.find().sort({ _id : 1 })"

echo "[CHECK DATA IN SHARD01]"
docker-compose exec shard01-a mongosh --quiet --eval "db.test1.find().sort({ _id : 1 })"
docker-compose exec shard01-a mongosh --quiet --eval "db.test2.find().sort({ _id : 1 })"

echo "[CHECK DATA IN SHARD02]"
docker-compose exec shard02-a mongosh --quiet --eval "db.test1.find().sort({ _id : 1 })"
docker-compose exec shard02-a mongosh --quiet --eval "db.test2.find().sort({ _id : 1 })"

echo "[CHECK DATA IN SHARD03]"
docker-compose exec shard03-a mongosh --quiet --eval "db.test1.find().sort({ _id : 1 })"
docker-compose exec shard03-a mongosh --quiet --eval "db.test2.find().sort({ _id : 1 })"
