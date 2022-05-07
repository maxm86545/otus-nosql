#!/usr/bin/bash

set -e
[ "$MONGODB_CONTAINER" = 'true' ] || (echo 'Not in mongodb container' && exit 1)

echo 'MONGO_VERSION: '"$MONGO_VERSION"

echo '=== INSTALL DEPENDENCIES ==='

apt update && apt install curl

echo '=== DOWNLOAD AND IMPORT DATASETS ==='

curl https://raw.githubusercontent.com/prust/wikipedia-movie-data/master/movies.json -o movies.json &&
  mongoimport --db test --collection movies --drop --jsonArray --file movies.json &&
  rm movies.json

curl https://media.mongodb.org/zips.json -o zips.json &&
  mongoimport --db test --collection zips --drop --type json --file zips.json &&
  rm zips.json

echo '=== QUERIES ==='

mongotest() {
  echo '=== Execute query: '"$1"

  if [ "$2" = 1 ]; then
    echo -n 'Query time ms: '
    mongo test --quiet --eval "$1"'.explain('\''executionStats'\'').executionStats.executionTimeMillis'
  else
    mongo test --quiet --eval "$1"
  fi

  echo '======================================================'
  echo ''
}

function movies.find() {
  mongotest 'db.movies.find({ year: { $gte: 2000, $lte: 2005 } })' 1
  mongotest 'db.movies.find({ year: { $gte: 2000, $lte: 2005 } }).sort({ year: 1 })' 1
  mongotest 'db.movies.find().sort({ year: 1 })' 1
  mongotest 'db.movies.find({ title: "The Dark Knight" })' 1
  mongotest 'db.movies.find({ title: { $regex: "Batman" } }).sort({ year: 1 })' 1
}

function zips.find() {
  mongotest 'db.zips.find({ state: '\''CA'\'' })' 1
  mongotest 'db.zips.find({ state: '\''CA'\'' }).sort({ city: 1 })' 1
  mongotest 'db.zips.find().sort({ city: 1 })' 1
}

mongotest 'db.movies.count()'
movies.find
mongotest 'db.movies.createIndex({ year: 1 }).ok'
movies.find

mongotest 'db.zips.count()'
zips.find
mongotest 'db.zips.createIndex({ state: 1 }).ok'
zips.find

mongotest 'db.test.drop()'
mongotest 'db.test.insert({ _id: 1, field1: 1, field2: 1 })'
mongotest 'db.test.update({ _id: 2 }, { field1: 20, field2: 20 })'
mongotest 'db.test.insert({ _id: 2, field1: 2, field2: 2 })'
mongotest 'db.test.update({ _id: 1 }, { field1: 11 })'
mongotest 'db.test.update({ _id: 2 }, { $set: { field1: 22 } })'
mongotest 'db.test.find()'
mongotest 'db.test.drop()'
