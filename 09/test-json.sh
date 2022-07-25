#!/bin/sh

TMP_FILE='/tmp/redis-test'
COUNT=1000000

EXECUTE_TMP_FILE() {
  echo "EXECUTE_TMP_FILE"
  time redis-cli <"$TMP_FILE"
}

EXECUTE_TMP_FILE_PIPE() {
  echo "EXECUTE_TMP_FILE_PIPE"
  time redis-cli --pipe <"$TMP_FILE"
}

TRUNCATE_TMP_FILE() {
  rm -f "$TMP_FILE"
  touch "$TMP_FILE"
}

SET_PREPARE_TMP_FILE() {
  echo "SET_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  echo -n "SET string '{" >>"$TMP_FILE"

  i=0
  while [ $i -lt "$COUNT" ]; do
    echo -n "\"field$i\":\"field-test-$i\"," >>"$TMP_FILE"
    i=$((i + 1))
  done

  echo -n "\"field$i\":\"field-test-$i\"" >>"$TMP_FILE"

  echo "}'" >>"$TMP_FILE"
  echo >>"$TMP_FILE"

  wc -c "$TMP_FILE"
}

HSET_PREPARE_TMP_FILE() {
  echo "HSET_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  i=0
  while [ $i -lt "$COUNT" ]; do
    echo "HSET hash 'field$i' 'field-test-$i'" >>"$TMP_FILE"
    i=$((i + 1))
  done

  wc -c "$TMP_FILE"
}

ZADD_PREPARE_TMP_FILE() {
  echo "ZADD_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  i=0
  while [ $i -lt "$COUNT" ]; do
    echo "ZADD sortedset $i 'field-test-$i'" >>"$TMP_FILE"
    i=$((i + 1))
  done

  wc -c "$TMP_FILE"
}

RPUSH_PREPARE_TMP_FILE() {
  echo "RPUSH_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  i=0
  while [ $i -lt "$COUNT" ]; do
    echo "RPUSH list 'field-test-$i'" >>"$TMP_FILE"
    i=$((i + 1))
  done

  wc -c "$TMP_FILE"
}

GET_PREPARE_TMP_FILE() {
  echo "GET_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  echo "GET string" >>"$TMP_FILE"

  wc -c "$TMP_FILE"
}

HGET_PREPARE_TMP_FILE() {
  echo "HGET_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  i=0
  while [ $i -lt "$COUNT" ]; do
    echo "HGET hash 'field$i'" >>"$TMP_FILE"
    i=$((i + 1))
  done

  wc -c "$TMP_FILE"

}

HGETALL_PREPARE_TMP_FILE() {
  echo "HGETALL_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  echo "HGETALL hash" >>"$TMP_FILE"

  wc -c "$TMP_FILE"
}

ZRANGE_PREPARE_TMP_FILE() {
  echo "ZRANGE_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  echo "ZRANGE sortedset 0 -1" >>"$TMP_FILE"

  wc -c "$TMP_FILE"
}

LRANGE_PREPARE_TMP_FILE() {
  echo "LRANGE_PREPARE_TMP_FILE"

  TRUNCATE_TMP_FILE

  echo "LRANGE list 0 -1" >>"$TMP_FILE"

  wc -c "$TMP_FILE"
}

redis-cli FLUSHALL
echo

SET_PREPARE_TMP_FILE
EXECUTE_TMP_FILE
echo

HSET_PREPARE_TMP_FILE
EXECUTE_TMP_FILE_PIPE
echo

ZADD_PREPARE_TMP_FILE
EXECUTE_TMP_FILE_PIPE
echo

RPUSH_PREPARE_TMP_FILE
EXECUTE_TMP_FILE_PIPE
echo

echo

GET_PREPARE_TMP_FILE
EXECUTE_TMP_FILE_PIPE
echo

HGET_PREPARE_TMP_FILE
EXECUTE_TMP_FILE_PIPE
echo

HGETALL_PREPARE_TMP_FILE
EXECUTE_TMP_FILE_PIPE
echo

ZRANGE_PREPARE_TMP_FILE
EXECUTE_TMP_FILE_PIPE
echo

LRANGE_PREPARE_TMP_FILE
EXECUTE_TMP_FILE_PIPE
echo
