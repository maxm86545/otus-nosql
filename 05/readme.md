# Elasticsearch test

## Тестовые данные
- Индекс `test`, 3 документа.

## Тестовая среда

**Elasticsearch 8.2.2**.

Сборка:
````bash
docker-compose up -d
````

Инициализация данных:
````bash
docker-compose exec elasticsearch /init.sh
````

Запуск теста:
````bash
docker-compose exec elasticsearch /test.sh
````

Очистка:
````bash
docker-compose down -v
````

## Пример вывода

Инициализация данных:
````bash
=== GET /
Response:
{
  "name" : "elasticsearch",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "uiqoXMXRS42NECF1hXaVKQ",
  "version" : {
    "number" : "8.2.2",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "9876968ef3c745186b94fdabd4483e01499224ef",
    "build_date" : "2022-05-25T15:47:06.259735307Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}

=======================================
=== GET /_cluster/health
Response:
{"cluster_name":"elasticsearch","status":"yellow","timed_out":false,"number_of_nodes":1,"number_of_data_nodes":1,"active_primary_shards":2,"active_shards":2,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":1,"delayed_unassigned_shards":0,"number_of_pending_tasks":0,"number_of_in_flight_fetch":0,"task_max_waiting_in_queue_millis":0,"active_shards_percent_as_number":66.66666666666666}
=======================================
=== DELETE /test
Response:
{"acknowledged":true}
=======================================
=== PUT /test
{
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
}
Response:
{"acknowledged":true,"shards_acknowledged":true,"index":"test"}
=======================================
=== POST /test/_bulk
{ "create" : { "_id" : "1" } }
{ "text" : "моя мама мыла посуду а кот жевал сосиски" }
{ "create" : { "_id" : "2" } }
{ "text" : "рама была отмыта и вылизана котом" }
{ "create" : { "_id" : "3" } }
{ "text" : "мама мыла раму" }

Response:
{"took":6,"errors":false,"items":[{"create":{"_index":"test","_id":"1","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":0,"_primary_term":1,"status":201}},{"create":{"_index":"test","_id":"2","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":1,"_primary_term":1,"status":201}},{"create":{"_index":"test","_id":"3","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":2,"_primary_term":1,"status":201}}]}
````

Тест:
````bash
=== POST /test/_search?pretty
{
  "query": {
    "match": {
      "text": {
        "query": "мама ела сосиски",
        "fuzziness": "auto"
      }
    }
  }
}
Response:
{
  "took" : 6,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 3,
      "relation" : "eq"
    },
    "max_score" : 1.2535897,
    "hits" : [
      {
        "_index" : "test",
        "_id" : "1",
        "_score" : 1.2535897,
        "_source" : {
          "text" : "моя мама мыла посуду а кот жевал сосиски"
        }
      },
      {
        "_index" : "test",
        "_id" : "3",
        "_score" : 0.89614034,
        "_source" : {
          "text" : "мама мыла раму"
        }
      },
      {
        "_index" : "test",
        "_id" : "2",
        "_score" : 0.3235163,
        "_source" : {
          "text" : "рама была отмыта и вылизана котом"
        }
      }
    ]
  }
}

=======================================
````
