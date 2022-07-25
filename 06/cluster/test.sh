#!/bin/bash

function clickhouse-test() {
  QUERY=$(cat)
  echo "=== Execute query: "
  echo "$QUERY"
  echo
  echo "= Query result: "
  exec 3>&1
  QUERY_TIME=$(clickhouse-client -t --query "$QUERY" 2>&1 1>&3)
  exec 3>&-
  echo -n "= Query time ms: "
  echo "$QUERY_TIME"
  echo '======================================================'
  echo
}


clickhouse-test <<-"SQL"
  SELECT COUNT(*)
  FROM test.uk_price_paid
SQL

clickhouse-test <<-"SQL"
  SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 1000000, 80)
  FROM test.uk_price_paid
  GROUP BY year
  ORDER BY year
SQL

clickhouse-test <<-"SQL"
  SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 2000000, 100)
  FROM test.uk_price_paid
  WHERE town = 'LONDON'
  GROUP BY year
  ORDER BY year
SQL

clickhouse-test <<-"SQL"
  SELECT
    town,
    district,
    count() AS c,
    round(avg(price)) AS price,
    bar(price, 0, 5000000, 100)
  FROM test.uk_price_paid
  WHERE date >= '2020-01-01'
  GROUP BY
    town,
    district
  HAVING c >= 100
  ORDER BY price DESC
  LIMIT 100
SQL
