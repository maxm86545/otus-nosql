# Mongodb test

## Тестовые данные
- Коллекция `movies` с 28795 документами, [источник](https://raw.githubusercontent.com/prust/wikipedia-movie-data/master/movies.json).
- Коллекция `zips` с 29353 документами, [источник](https://media.mongodb.org/zips.json).
- Коллекция `test` с 2 документами.

## Тестовый контейнер

Сборка:
````bash
docker-compose up -d
````

Запуск теста:
````bash
docker-compose exec mongodb-test ./test.sh
````

## Пример вывода тестового скрипта

### Версия `5.0.8`

````bash
MONGO_VERSION: 5.0.8

// ...

=== QUERIES ===
=== Execute query: db.movies.count()
28795
======================================================

=== Execute query: db.movies.find({ year: { $gte: 2000, $lte: 2005 } })
Query time ms: 28
======================================================

=== Execute query: db.movies.find({ year: { $gte: 2000, $lte: 2005 } }).sort({ year: 1 })
Query time ms: 30
======================================================

=== Execute query: db.movies.find().sort({ year: 1 })
Query time ms: 58
======================================================

=== Execute query: db.movies.find({ title: "The Dark Knight" })
Query time ms: 21
======================================================

=== Execute query: db.movies.find({ title: { $regex: "Batman" } }).sort({ year: 1 })
Query time ms: 20
======================================================

=== Execute query: db.movies.createIndex({ year: 1 }).ok
1
======================================================

=== Execute query: db.movies.find({ year: { $gte: 2000, $lte: 2005 } })
Query time ms: 2
======================================================

=== Execute query: db.movies.find({ year: { $gte: 2000, $lte: 2005 } }).sort({ year: 1 })
Query time ms: 1
======================================================

=== Execute query: db.movies.find().sort({ year: 1 })
Query time ms: 39
======================================================

=== Execute query: db.movies.find({ title: "The Dark Knight" })
Query time ms: 14
======================================================

=== Execute query: db.movies.find({ title: { $regex: "Batman" } }).sort({ year: 1 })
Query time ms: 50
======================================================

=== Execute query: db.zips.count()
29353
======================================================

=== Execute query: db.zips.find({ state: 'CA' })
Query time ms: 15
======================================================

=== Execute query: db.zips.find({ state: 'CA' }).sort({ city: 1 })
Query time ms: 18
======================================================

=== Execute query: db.zips.find().sort({ city: 1 })
Query time ms: 46
======================================================

=== Execute query: db.zips.createIndex({ state: 1 }).ok
1
======================================================

=== Execute query: db.zips.find({ state: 'CA' })
Query time ms: 2
======================================================

=== Execute query: db.zips.find({ state: 'CA' }).sort({ city: 1 })
Query time ms: 3
======================================================

=== Execute query: db.zips.find().sort({ city: 1 })
Query time ms: 66
======================================================

=== Execute query: db.test.drop()
false
======================================================

=== Execute query: db.test.insert({ _id: 1, field1: 1, field2: 1 })
WriteResult({ "nInserted" : 1 })
======================================================

=== Execute query: db.test.update({ _id: 2 }, { field1: 20, field2: 20 })
WriteResult({ "nMatched" : 0, "nUpserted" : 0, "nModified" : 0 })
======================================================

=== Execute query: db.test.insert({ _id: 2, field1: 2, field2: 2 })
WriteResult({ "nInserted" : 1 })
======================================================

=== Execute query: db.test.update({ _id: 1 }, { field1: 11 })
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
======================================================

=== Execute query: db.test.update({ _id: 2 }, { $set: { field1: 22 } })
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
======================================================

=== Execute query: db.test.find()
{ "_id" : 1, "field1" : 11 }
{ "_id" : 2, "field1" : 22, "field2" : 2 }
======================================================

=== Execute query: db.test.drop()
true
======================================================

````

### Версия `4.4.13`

````bash
MONGO_VERSION: 4.4.13

// ...

=== QUERIES ===
=== Execute query: db.movies.count()
28795
======================================================

=== Execute query: db.movies.find({ year: { $gte: 2000, $lte: 2005 } })
Query time ms: 15
======================================================

=== Execute query: db.movies.find({ year: { $gte: 2000, $lte: 2005 } }).sort({ year: 1 })
Query time ms: 18
======================================================

=== Execute query: db.movies.find().sort({ year: 1 })
Query time ms: 26
======================================================

=== Execute query: db.movies.find({ title: "The Dark Knight" })
Query time ms: 12
======================================================

=== Execute query: db.movies.find({ title: { $regex: "Batman" } }).sort({ year: 1 })
Query time ms: 22
======================================================

=== Execute query: db.movies.createIndex({ year: 1 }).ok
1
======================================================

=== Execute query: db.movies.find({ year: { $gte: 2000, $lte: 2005 } })
Query time ms: 3
======================================================

=== Execute query: db.movies.find({ year: { $gte: 2000, $lte: 2005 } }).sort({ year: 1 })
Query time ms: 1
======================================================

=== Execute query: db.movies.find().sort({ year: 1 })
Query time ms: 27
======================================================

=== Execute query: db.movies.find({ title: "The Dark Knight" })
Query time ms: 12
======================================================

=== Execute query: db.movies.find({ title: { $regex: "Batman" } }).sort({ year: 1 })
Query time ms: 33
======================================================

=== Execute query: db.zips.count()
29353
======================================================

=== Execute query: db.zips.find({ state: 'CA' })
Query time ms: 13
======================================================

=== Execute query: db.zips.find({ state: 'CA' }).sort({ city: 1 })
Query time ms: 16
======================================================

=== Execute query: db.zips.find().sort({ city: 1 })
Query time ms: 38
======================================================

=== Execute query: db.zips.createIndex({ state: 1 }).ok
1
======================================================

=== Execute query: db.zips.find({ state: 'CA' })
Query time ms: 3
======================================================

=== Execute query: db.zips.find({ state: 'CA' }).sort({ city: 1 })
Query time ms: 3
======================================================

=== Execute query: db.zips.find().sort({ city: 1 })
Query time ms: 39
======================================================

=== Execute query: db.test.drop()
false
======================================================

=== Execute query: db.test.insert({ _id: 1, field1: 1, field2: 1 })
WriteResult({ "nInserted" : 1 })
======================================================

=== Execute query: db.test.update({ _id: 2 }, { field1: 20, field2: 20 })
WriteResult({ "nMatched" : 0, "nUpserted" : 0, "nModified" : 0 })
======================================================

=== Execute query: db.test.insert({ _id: 2, field1: 2, field2: 2 })
WriteResult({ "nInserted" : 1 })
======================================================

=== Execute query: db.test.update({ _id: 1 }, { field1: 11 })
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
======================================================

=== Execute query: db.test.update({ _id: 2 }, { $set: { field1: 22 } })
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
======================================================

=== Execute query: db.test.find()
{ "_id" : 1, "field1" : 11 }
{ "_id" : 2, "field1" : 22, "field2" : 2 }
======================================================

=== Execute query: db.test.drop()
true
======================================================

````

### Сравнительная таблица

| Query                                                                    | Without index by `year`            | With index by `year`               |
|--------------------------------------------------------------------------|------------------------------------|------------------------------------|
| `db.movies.find({ year: { $gte: 2000, $lte: 2005 } })`                   | `5.0.8`: 28 ms<br/>`4.4.13`: 15 ms | `5.0.8`: 2 ms<br/>`4.4.13`: 3 ms   |
| `db.movies.find({ year: { $gte: 2000, $lte: 2005 } }).sort({ year: 1 })` | `5.0.8`: 30 ms<br/>`4.4.13`: 18 ms | `5.0.8`: 1 ms<br/>`4.4.13`: 1 ms   |
| `db.movies.find().sort({ year: 1 })`                                     | `5.0.8`: 58 ms<br/>`4.4.13`: 26 ms | `5.0.8`: 39 ms<br/>`4.4.13`: 27 ms |
