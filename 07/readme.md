# Couchbase test

## Тестовые данные
- Бакет `travel-sample` с 63288 документами, [источник](https://docs.couchbase.com/server/current/manage/manage-settings/install-sample-buckets.html).

## Тестовый кластер

Сборка:
````bash
docker-compose up -d
````

Инициализация кластера:
````bash
docker-compose exec couchbase-1 ./init.sh
````

Запуск теста:
````bash
./test.sh
````

Очистка:
````bash
docker-compose down -v
````

## Пример вывода

Инициализация кластера:
````bash
[Cluster couchbase-1.local with data init] SUCCESS: Cluster initialized
[Setting autofailover for cluster couchbase-1.local] SUCCESS: Auto-failover settings modified
[Server couchbase-2.local,couchbase-3.local with data add to cluster couchbase-1.local] SUCCESS: Server added
[Server couchbase-4.local with index add to cluster couchbase-1.local] SUCCESS: Server added
[Server couchbase-5.local with query add to cluster couchbase-1.local] SUCCESS: Server added
[Server couchbase-6.local with fts,eventing,analytics,backup add to cluster couchbase-1.local] SUCCESS: Server added
[Rebalance cluster couchbase-1.local] SUCCESS: Rebalance complete
[Server list for cluster couchbase-1.local]
ns_1@172.24.0.7 172.24.0.7:8091 healthy active
ns_1@couchbase-2.local couchbase-2.local:8091 healthy active
ns_1@couchbase-3.local couchbase-3.local:8091 healthy active
ns_1@couchbase-4.local couchbase-4.local:8091 healthy active
ns_1@couchbase-5.local couchbase-5.local:8091 healthy active
ns_1@couchbase-6.local couchbase-6.local:8091 healthy active
````

Тестовый скрипт:
````bash
[Install sample] []
[Test query to couchbase-1.local]
{
    "requestID": "348f21dc-a52b-436f-b906-ae4675d4ed00",
    "signature": {
        "$1": "number"
    },
    "results": [
    {
        "$1": 187
    }
    ],
    "status": "success",
    "metrics": {
        "elapsedTime": "12.760141ms",
        "executionTime": "12.539233ms",
        "resultCount": 1,
        "resultSize": 25,
        "serviceLoad": 4
    }
}
[Test query to couchbase-2.local]
// ...
````

## Интересности

### Сервисы
> **Data**: Supports the storing, setting, and retrieving of data-items, specified by key.

> **Query**: Parses queries specified in the N1QL query-language, executes the queries, and returns results. The Query Service interacts with both the Data and Index services.

> **Index**: Creates indexes, for use by the Query and Analytics services.

> **Search**: Create indexes specially purposed for Full Text Search. This supports language-aware searching; allowing users to search for, say, the word beauties, and additionally obtain results for beauty and beautiful.

> **Analytics**: Supports join, set, aggregation, and grouping operations; which are expected to be large, long-running, and highly consumptive of memory and CPU resources.

> **Eventing**: Supports near real-time handling of changes to data: code can be executed both in response to document-mutations, and as scheduled by timers.

> **Backup**: Supports the scheduling of full and incremental data backups, either for specific individual buckets, or for all buckets on the cluster. Also allows the scheduling of merges of previously made backups.

**Источник:**
https://docs.couchbase.com/server/current/learn/services-and-indexes/services/services.html#services-and-multi-dimensional-scaling


### Счетчик Auto-failover
Auto-failover имеет счетчик максимальное значение которого равно 1, 2 или 3. Для дальнейшей работы Auto-failover это значение необходимо сбрасывать.

**Источник:**
https://docs.couchbase.com/server/current/cli/cbcli/couchbase-cli-setting-autofailover.html

> **--max-failovers** <**num**>
> 
> Specifies the number of auto-failover events that will be handled before requiring user intervention. A single event could be one node failing over or an entire Server Group. The maximum allowed value is three. This feature is only available in Couchbase Enterprise Edition.
>

### Баг или фича?
При падании ноды и использовании failover для вывода ноды из работающего кластера становиться проблемно вернуть эту ноду: добавление в кластер старой ноды дает "_Prepare join failed. Node is already part of cluster._" (**нода является частью кластера**), а ручной failover говорит "_Server can't be failed over because it's not part of the cluster_" (**нода НЕ является частью кластера**). Дело в том, что упавшая нода сохранила старое состояние кластера и не может соединиться с работающим кластером.
