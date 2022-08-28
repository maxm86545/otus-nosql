# Tarantool cluster test

## Тестовая среда

**Tarantool 2.10.2, 3 nodes**.

Сборка:
````bash
docker-compose up -d
````

Запуск теста:
````bash
docker-compose exec tarantool_tarantool1 sh -c 'console < /opt/tarantool/test.lua'
````

Лог nginx:
````bash
docker logs tarantool_nginx
````

Очистка:
````bash
docker-compose down -v
````

## Пример вывода

Тест:
````bash
connected to unix/:/var/run/tarantool/tarantool.sock
unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
- unique: true
  parts:
  - type: unsigned
    is_nullable: false
    fieldno: 1
  id: 0
  space_id: 512
  type: HASH
  name: primary
...

unix/:/var/run/tarantool/tarantool.sock> ---
- unique: false
  parts:
  - type: string
    is_nullable: false
    fieldno: 2
  hint: true
  id: 1
  type: TREE
  space_id: 512
  name: status
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock>                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        >                                        > ---
- guardian_fiber:
    status: suspended
    name: guardian of "vps-stop"
    id: 126
  force: true
  worker_fiber:
    status: suspended
    name: worker of "vps-stop"
    id: 127
  do_worker_iteration: 'function: 0x7f5c7fa1a398'
  start_key: 'function: 0x7f5c662d0b08'
  iterate_with: 'function: 0x7f5c7fa18f18'
  atomic_iteration: false
  index:
    unique: true
    parts:
    - type: unsigned
      is_nullable: false
      fieldno: 1
    id: 0
    type: HASH
    space_id: 512
    name: primary
  full_scan_time: 3600
  process_expired_tuple: 'function: 0x7f5c662d0940'
  is_tuple_expired: 'function: 0x7f5c662d0d98'
  iteration_delay: 1
  space_id: 512
  iterator_type: ALL
  worker_cancelled: false
  on_full_scan_error: 'function: 0x7f5c7fa1a188'
  on_full_scan_start: 'function: 0x7f5c7fa1a188'
  vinyl_assumed_space_len_factor: 2
  expired_tuples_count: 0
  checked_tuples_count: 0
  full_scan_delay: 1
  start_time: 1661720987.0417
  vinyl_assumed_space_len: 10000000
  restarts: 1
  on_full_scan_success: 'function: 0x7f5c7fa1a188'
  tuples_per_iteration: 50
  on_full_scan_complete: 'function: 0x7f5c7fa1a188'
  name: vps-stop
  process_while: 'function: 0x7f5c7fa1a1e8'
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
- [1, 'stopped', 0]
...

unix/:/var/run/tarantool/tarantool.sock> ---
- [2, 'started', 2]
...

unix/:/var/run/tarantool/tarantool.sock> ---
- [3, 'started', 5]
...

unix/:/var/run/tarantool/tarantool.sock> ---
- [4, 'started', 10]
...

unix/:/var/run/tarantool/tarantool.sock> ---
- [5, 'started', 50]
...

unix/:/var/run/tarantool/tarantool.sock> ---
- [6, 'stopped', 70]
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
- - [1, 'stopped', 0]
  - [2, 'started', 2]
  - [3, 'started', 5]
  - [4, 'started', 10]
  - [5, 'started', 50]
  - [6, 'stopped', 70]
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock>                                        >                                        >                                        >                                        >                                        > ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
...

unix/:/var/run/tarantool/tarantool.sock> ---
- - [1, 'stopped', 0]
  - [2, 'stopped', 0]
  - [3, 'stopped', 0]
  - [4, 'stopped', 0]
  - [5, 'started', 40]
  - [6, 'stopped', 70]
...

unix/:/var/run/tarantool/tarantool.sock> 
````

Лог nginx:
````bash
// ...
172.30.0.5 - - [28/Aug/2022:21:09:49 +0000] "GET /?action=stop&user_id=2 HTTP/1.1" 200 615 "-" "-" "-"
172.30.0.5 - - [28/Aug/2022:21:09:52 +0000] "GET /?action=stop&user_id=3 HTTP/1.1" 200 615 "-" "-" "-"
172.30.0.5 - - [28/Aug/2022:21:09:57 +0000] "GET /?action=stop&user_id=4 HTTP/1.1" 200 615 "-" "-" "-"
````