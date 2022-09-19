# Manticore Search cluster test

## Тестовая среда

**Manticore Search 5.0.2, 3 nodes**.

Инициализация:
````bash
./init-cluster.sh
````

Запуск теста:
````bash
./test-cluster.sh
````

Очистка:
````bash
docker-compose down -v
````

## Пример вывода

Инициализация:
````bash
[START NODES]
[+] Running 4/4
 ⠿ Network 16_manticore  Created                                                                                                                                                                                 0.1s
 ⠿ Container manticore3  Started                                                                                                                                                                                 0.8s
 ⠿ Container manticore2  Started                                                                                                                                                                                 0.8s
 ⠿ Container manticore1  Started                                                                                                                                                                                 0.6s
[CREATE CLUSTER]
+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Counter               | Value                                                                                                                                                 |
+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| cluster_my_node_state | synced                                                                                                                                                |
| cluster_my_nodes_set  | 192.168.160.2:9312,192.168.160.3:9312,192.168.160.4:9312                                                                                              |
| cluster_my_nodes_view | 192.168.160.2:9312,192.168.160.2:9315:replication,192.168.160.3:9312,192.168.160.3:9315:replication,192.168.160.4:9312,192.168.160.4:9315:replication |
+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
[CREATE DISTRIBUTED INDEX]
[GET DATA]
+------+-------+
| id   | test  |
+------+-------+
|    1 | test1 |
|    2 | test2 |
+------+-------+
+------+-------+
| id   | test  |
+------+-------+
|    1 | test1 |
|    2 | test2 |
+------+-------+
````

Тест:
````bash
[STOP NODE1]
[+] Running 1/1
 ⠿ Container manticore1  Stopped                                                                                                                                                                                 0.3s
[INSERT DATA]
[START NODE1]
[+] Running 1/1
 ⠿ Container manticore1  Started                                                                                                                                                                                 0.7s
[GET DATA FROM NODE1]
+------+-------+
| id   | test  |
+------+-------+
|    5 | test5 |
|    3 | test3 |
|    1 | test1 |
|    4 | test4 |
|    2 | test2 |
+------+-------+
````
