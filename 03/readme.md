# Mongodb cluster test

## Тестовая среда

Mongo 5.0.11, 2x mongos, 3x configsvr, 3x3 shards

Сборка:
````bash
docker-compose up -d
````

Запуск теста:
````bash
./test.sh
````

Очистка:
````bash
docker-compose down -v
````

## Пример вывода тестового скрипта

````bash
[CONFIGURE CONFIG SERVERS]
{
  ok: 1,
  '$gleStats': {
    lastOpTime: Timestamp({ t: 1662400097, i: 1 }),
    electionId: ObjectId("000000000000000000000000")
  },
  lastCommittedOpTime: Timestamp({ t: 1662400097, i: 1 })
}
[CONFIGURE SHARD01]
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1662400098, i: 1 }),
    signature: {
      hash: Binary(Buffer.from("0000000000000000000000000000000000000000", "hex"), 0),
      keyId: Long("0")
    }
  },
  operationTime: Timestamp({ t: 1662400098, i: 1 })
}
[CONFIGURE SHARD02]
{ ok: 1 }
[CONFIGURE ROUTERS]
[ADD SHARD01]
{
  shardAdded: 'rs-shard-01',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1662400113, i: 5 }),
    signature: {
      hash: Binary(Buffer.from("0000000000000000000000000000000000000000", "hex"), 0),
      keyId: Long("0")
    }
  },
  operationTime: Timestamp({ t: 1662400113, i: 5 })
}
[ADD SHARD02]
{
  shardAdded: 'rs-shard-02',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1662400117, i: 3 }),
    signature: {
      hash: Binary(Buffer.from("0000000000000000000000000000000000000000", "hex"), 0),
      keyId: Long("0")
    }
  },
  operationTime: Timestamp({ t: 1662400117, i: 3 })
}
[CREATE SHARD COLLECTION]
{
  collectionsharded: 'test.test2',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1662400119, i: 63 }),
    signature: {
      hash: Binary(Buffer.from("0000000000000000000000000000000000000000", "hex"), 0),
      keyId: Long("0")
    }
  },
  operationTime: Timestamp({ t: 1662400119, i: 59 })
}
[INSERT DATA]
{ acknowledged: true, insertedId: 18 }
{ acknowledged: true, insertedId: 18 }
[CHECK DATA]
[
  { _id: 1, t1field1: 1, t1field2: 1 },
  { _id: 2, t1field1: 2, t1field2: 2 },
  { _id: 3, t1field1: 3, t1field2: 3 },
  { _id: 4, t1field1: 4, t1field2: 4 },
  { _id: 5, t1field1: 5, t1field2: 5 },
  { _id: 6, t1field1: 6, t1field2: 6 },
  { _id: 7, t1field1: 7, t1field2: 7 },
  { _id: 8, t1field1: 8, t1field2: 8 },
  { _id: 9, t1field1: 9, t1field2: 9 },
  { _id: 10, t1field1: 10, t1field2: 10 },
  { _id: 11, t1field1: 11, t1field2: 11 },
  { _id: 12, t1field1: 12, t1field2: 12 },
  { _id: 13, t1field1: 13, t1field2: 13 },
  { _id: 14, t1field1: 14, t1field2: 14 },
  { _id: 15, t1field1: 15, t1field2: 15 },
  { _id: 16, t1field1: 16, t1field2: 16 },
  { _id: 17, t1field1: 17, t1field2: 17 },
  { _id: 18, t1field1: 18, t1field2: 18 }
]
[
  { _id: 1, t2field1: 1, t2field2: 1 },
  { _id: 2, t2field1: 2, t2field2: 2 },
  { _id: 3, t2field1: 3, t2field2: 3 },
  { _id: 4, t2field1: 4, t2field2: 4 },
  { _id: 5, t2field1: 5, t2field2: 5 },
  { _id: 6, t2field1: 6, t2field2: 6 },
  { _id: 7, t2field1: 7, t2field2: 7 },
  { _id: 8, t2field1: 8, t2field2: 8 },
  { _id: 9, t2field1: 9, t2field2: 9 },
  { _id: 10, t2field1: 10, t2field2: 10 },
  { _id: 11, t2field1: 11, t2field2: 11 },
  { _id: 12, t2field1: 12, t2field2: 12 },
  { _id: 13, t2field1: 13, t2field2: 13 },
  { _id: 14, t2field1: 14, t2field2: 14 },
  { _id: 15, t2field1: 15, t2field2: 15 },
  { _id: 16, t2field1: 16, t2field2: 16 },
  { _id: 17, t2field1: 17, t2field2: 17 },
  { _id: 18, t2field1: 18, t2field2: 18 }
]
[CHECK DATA IN SHARD01]
[
  { _id: 3, t1field1: 3, t1field2: 3 },
  { _id: 6, t1field1: 6, t1field2: 6 },
  { _id: 8, t1field1: 8, t1field2: 8 },
  { _id: 11, t1field1: 11, t1field2: 11 },
  { _id: 12, t1field1: 12, t1field2: 12 }
]
[
  { _id: 1, t2field1: 1, t2field2: 1 },
  { _id: 2, t2field1: 2, t2field2: 2 },
  { _id: 3, t2field1: 3, t2field2: 3 },
  { _id: 4, t2field1: 4, t2field2: 4 },
  { _id: 5, t2field1: 5, t2field2: 5 },
  { _id: 6, t2field1: 6, t2field2: 6 },
  { _id: 7, t2field1: 7, t2field2: 7 },
  { _id: 8, t2field1: 8, t2field2: 8 },
  { _id: 9, t2field1: 9, t2field2: 9 },
  { _id: 10, t2field1: 10, t2field2: 10 },
  { _id: 11, t2field1: 11, t2field2: 11 },
  { _id: 12, t2field1: 12, t2field2: 12 },
  { _id: 13, t2field1: 13, t2field2: 13 },
  { _id: 14, t2field1: 14, t2field2: 14 },
  { _id: 15, t2field1: 15, t2field2: 15 },
  { _id: 16, t2field1: 16, t2field2: 16 },
  { _id: 17, t2field1: 17, t2field2: 17 },
  { _id: 18, t2field1: 18, t2field2: 18 }
]
[CHECK DATA IN SHARD02]
[
  { _id: 1, t1field1: 1, t1field2: 1 },
  { _id: 2, t1field1: 2, t1field2: 2 },
  { _id: 4, t1field1: 4, t1field2: 4 },
  { _id: 5, t1field1: 5, t1field2: 5 },
  { _id: 7, t1field1: 7, t1field2: 7 },
  { _id: 9, t1field1: 9, t1field2: 9 },
  { _id: 10, t1field1: 10, t1field2: 10 },
  { _id: 13, t1field1: 13, t1field2: 13 },
  { _id: 14, t1field1: 14, t1field2: 14 },
  { _id: 15, t1field1: 15, t1field2: 15 },
  { _id: 16, t1field1: 16, t1field2: 16 },
  { _id: 17, t1field1: 17, t1field2: 17 },
  { _id: 18, t1field1: 18, t1field2: 18 }
]
 
[STOP ROUTER01]
[+] Running 1/1
 ⠿ Container router-01  Stopped                                                                                                                                                                                 10.1s
[STOP SHARD01-C]
[+] Running 1/1
 ⠿ Container shard-01-c  Stopped                                                                                                                                                                                10.1s
[STOP SHARD02-B]
[+] Running 1/1
 ⠿ Container shard-02-b  Stopped                                                                                                                                                                                10.2s
[CONFIGURE SHARD03]
{ ok: 1 }
[ADD SHARD03]
{
  shardAdded: 'rs-shard-03',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1662400178, i: 3 }),
    signature: {
      hash: Binary(Buffer.from("0000000000000000000000000000000000000000", "hex"), 0),
      keyId: Long("0")
    }
  },
  operationTime: Timestamp({ t: 1662400178, i: 3 })
}
[CHECK DATA]
[
  { _id: 1, t1field1: 1, t1field2: 1 },
  { _id: 2, t1field1: 2, t1field2: 2 },
  { _id: 3, t1field1: 3, t1field2: 3 },
  { _id: 4, t1field1: 4, t1field2: 4 },
  { _id: 5, t1field1: 5, t1field2: 5 },
  { _id: 6, t1field1: 6, t1field2: 6 },
  { _id: 7, t1field1: 7, t1field2: 7 },
  { _id: 8, t1field1: 8, t1field2: 8 },
  { _id: 9, t1field1: 9, t1field2: 9 },
  { _id: 10, t1field1: 10, t1field2: 10 },
  { _id: 11, t1field1: 11, t1field2: 11 },
  { _id: 12, t1field1: 12, t1field2: 12 },
  { _id: 13, t1field1: 13, t1field2: 13 },
  { _id: 14, t1field1: 14, t1field2: 14 },
  { _id: 15, t1field1: 15, t1field2: 15 },
  { _id: 16, t1field1: 16, t1field2: 16 },
  { _id: 17, t1field1: 17, t1field2: 17 },
  { _id: 18, t1field1: 18, t1field2: 18 }
]
[
  { _id: 1, t2field1: 1, t2field2: 1 },
  { _id: 2, t2field1: 2, t2field2: 2 },
  { _id: 3, t2field1: 3, t2field2: 3 },
  { _id: 4, t2field1: 4, t2field2: 4 },
  { _id: 5, t2field1: 5, t2field2: 5 },
  { _id: 6, t2field1: 6, t2field2: 6 },
  { _id: 7, t2field1: 7, t2field2: 7 },
  { _id: 8, t2field1: 8, t2field2: 8 },
  { _id: 9, t2field1: 9, t2field2: 9 },
  { _id: 10, t2field1: 10, t2field2: 10 },
  { _id: 11, t2field1: 11, t2field2: 11 },
  { _id: 12, t2field1: 12, t2field2: 12 },
  { _id: 13, t2field1: 13, t2field2: 13 },
  { _id: 14, t2field1: 14, t2field2: 14 },
  { _id: 15, t2field1: 15, t2field2: 15 },
  { _id: 16, t2field1: 16, t2field2: 16 },
  { _id: 17, t2field1: 17, t2field2: 17 },
  { _id: 18, t2field1: 18, t2field2: 18 }
]
[CHECK DATA IN SHARD01]
[
  { _id: 3, t1field1: 3, t1field2: 3 },
  { _id: 6, t1field1: 6, t1field2: 6 },
  { _id: 8, t1field1: 8, t1field2: 8 },
  { _id: 11, t1field1: 11, t1field2: 11 },
  { _id: 12, t1field1: 12, t1field2: 12 }
]
[
  { _id: 1, t2field1: 1, t2field2: 1 },
  { _id: 2, t2field1: 2, t2field2: 2 },
  { _id: 3, t2field1: 3, t2field2: 3 },
  { _id: 4, t2field1: 4, t2field2: 4 },
  { _id: 5, t2field1: 5, t2field2: 5 },
  { _id: 6, t2field1: 6, t2field2: 6 },
  { _id: 7, t2field1: 7, t2field2: 7 },
  { _id: 8, t2field1: 8, t2field2: 8 },
  { _id: 9, t2field1: 9, t2field2: 9 },
  { _id: 10, t2field1: 10, t2field2: 10 },
  { _id: 11, t2field1: 11, t2field2: 11 },
  { _id: 12, t2field1: 12, t2field2: 12 },
  { _id: 13, t2field1: 13, t2field2: 13 },
  { _id: 14, t2field1: 14, t2field2: 14 },
  { _id: 15, t2field1: 15, t2field2: 15 },
  { _id: 16, t2field1: 16, t2field2: 16 },
  { _id: 17, t2field1: 17, t2field2: 17 },
  { _id: 18, t2field1: 18, t2field2: 18 }
]
[CHECK DATA IN SHARD02]
[
  { _id: 1, t1field1: 1, t1field2: 1 },
  { _id: 2, t1field1: 2, t1field2: 2 },
  { _id: 4, t1field1: 4, t1field2: 4 },
  { _id: 5, t1field1: 5, t1field2: 5 },
  { _id: 7, t1field1: 7, t1field2: 7 },
  { _id: 9, t1field1: 9, t1field2: 9 },
  { _id: 10, t1field1: 10, t1field2: 10 },
  { _id: 13, t1field1: 13, t1field2: 13 },
  { _id: 14, t1field1: 14, t1field2: 14 },
  { _id: 15, t1field1: 15, t1field2: 15 },
  { _id: 16, t1field1: 16, t1field2: 16 },
  { _id: 17, t1field1: 17, t1field2: 17 },
  { _id: 18, t1field1: 18, t1field2: 18 }
]
 
[CHECK DATA IN SHARD03]
[
  { _id: 6, t1field1: 6, t1field2: 6 },
  { _id: 8, t1field1: 8, t1field2: 8 },
  { _id: 12, t1field1: 12, t1field2: 12 }
]
 
````

### Комментарии
- С ключом range все данных появились на одной ноде из-за того что все id входят в диапазон для данной ноды.
- С ключом hashed при добавлении нового шарда на уже существующем кластере с данными часть данных появилось на новом шарде.
