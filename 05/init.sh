#!/bin/bash

set -e

function elastic() {
  REQUEST_METHOD=${1:-GET}
  REQUEST_PATH="/${2}"
  REQUEST_BODY=${3}

  echo "=== ${REQUEST_METHOD} ${REQUEST_PATH}"

  if [ "$REQUEST_BODY" != '' ]; then
    echo "$REQUEST_BODY"
  fi

  echo "Response:"

  curl --user "$ELASTIC_USER":"$ELASTIC_PASSWORD" \
    "localhost:9200${REQUEST_PATH}" \
    -X "${REQUEST_METHOD}" \
    -H 'Content-Type: application/json' \
    -d "${REQUEST_BODY}"

  echo
  echo "======================================="
}

elastic

elastic GET _cluster/health

elastic DELETE test

elastic PUT test \
'{
  "settings": {
    "analysis": {
      "filter": {
        "ru_stop": {
          "type": "stop",
          "stopwords": "_russian_"
        },
        "ru_stem": {
          "type": "stemmer",
          "language": "russian"
        }
      },
      "analyzer": {
        "my_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [ "lowercase", "ru_stop", "ru_stem" ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "text": {
        "type": "text",
        "analyzer": "my_analyzer"
      }
    }
  }
}'

elastic POST test/_bulk \
'{ "create" : { "_id" : "1" } }
{ "text" : "моя мама мыла посуду а кот жевал сосиски" }
{ "create" : { "_id" : "2" } }
{ "text" : "рама была отмыта и вылизана котом" }
{ "create" : { "_id" : "3" } }
{ "text" : "мама мыла раму" }
'
