# etcd cluster test

## Тестовая среда

**Etcd 3.4.18, 5 nodes**.

Сборка:
````bash
docker-compose up -d
````

Запуск теста:
````bash
./test-etcd.sh
````

Очистка:
````bash
docker-compose down -v
````

## Пример вывода

Тест:
````bash
[KEYS = 10][NODES = 5][FAILURE TOLERANCE = 2]

[NODE1] etcdctl member list
1e738073e57b0810, started, etcd3, http://etcd-3:2380, http://etcd-3:2379, false
7ab40cdf5677e876, started, etcd5, http://etcd-5:2380, http://etcd-5:2379, false
97ecdd3706cc2d90, started, etcd2, http://etcd-2:2380, http://etcd-2:2379, false
a3959071884acd0c, started, etcd1, http://etcd-1:2380, http://etcd-1:2379, false
eb60c5a827c7b5ca, started, etcd4, http://etcd-4:2380, http://etcd-4:2379, false

[NODE2] etcdctl del "" --from-key=true
0

[NODE1] etcdctl put key0 value0
OK

[NODE2] etcdctl put key1 value1
OK

[NODE3] etcdctl put key2 value2
OK

[NODE4] etcdctl put key3 value3
OK

[NODE5] etcdctl put key4 value4
OK

[NODE1] etcdctl put key5 value5
OK

[NODE2] etcdctl put key6 value6
OK

[NODE3] etcdctl put key7 value7
OK

[NODE4] etcdctl put key8 value8
OK

[NODE5] etcdctl put key9 value9
OK

[NODE1] etcdctl get --prefix key
key0
value0
key1
value1
key2
value2
key3
value3
key4
value4
key5
value5
key6
value6
key7
value7
key8
value8
key9
value9

[NODE1] STOP
[+] Running 1/1
 ⠿ Container etcd-1  Stopped                                                                                                                                                                                     0.8s

[NODE2] etcdctl get --prefix key
key0
value0
key1
value1
key2
value2
key3
value3
key4
value4
key5
value5
key6
value6
key7
value7
key8
value8
key9
value9

[NODE2] STOP
[+] Running 1/1
 ⠿ Container etcd-2  Stopped                                                                                                                                                                                     0.6s

[NODE5] etcdctl get --prefix key
key0
value0
key1
value1
key2
value2
key3
value3
key4
value4
key5
value5
key6
value6
key7
value7
key8
value8
key9
value9

[NODE3] STOP
[+] Running 1/1
 ⠿ Container etcd-3  Stopped                                                                                                                                                                                     0.6s

[NODE5] etcdctl get --prefix key
{"level":"warn","ts":"2022-07-06T19:12:10.999Z","caller":"clientv3/retry_interceptor.go:62","msg":"retrying of unary invoker failed","target":"endpoint://client-f891c00b-f249-4d71-9c84-61ef5d61e336/127.0.0.1:2379","attempt":0,"error":"rpc error: code = DeadlineExceeded desc = context deadline exceeded"}
Error: context deadline exceeded
````