#!/bin/bash

set -e

echo "[CREATE DATABASES]"

clickhouse-client <<- "SQL"
  CREATE DATABASE IF NOT EXISTS test ON CLUSTER my_cluster
SQL

echo "[CREATE DATABASES: OK]"


echo "[CREATE TABLES]"

function create_uk_price_paid_local_table() {
  clickhouse-client -h "$1" << SQL
    CREATE TABLE IF NOT EXISTS test.uk_price_paid_local
    (
        price UInt32,
        date Date,
        postcode1 LowCardinality(String),
        postcode2 LowCardinality(String),
        type Enum8('terraced' = 1, 'semi-detached' = 2, 'detached' = 3, 'flat' = 4, 'other' = 0),
        is_new UInt8,
        duration Enum8('freehold' = 1, 'leasehold' = 2, 'unknown' = 0),
        addr1 String,
        addr2 String,
        street LowCardinality(String),
        locality LowCardinality(String),
        town LowCardinality(String),
        district LowCardinality(String),
        county LowCardinality(String),
        category UInt8
    ) ENGINE = ReplicatedMergeTree('/clickhouse/tables/test/$2/uk_price_paid', '$3') ORDER BY (postcode1, postcode2, addr1, addr2);
SQL
}

create_uk_price_paid_local_table 'clickhouse-1' 1 1
create_uk_price_paid_local_table 'clickhouse-2' 1 2
create_uk_price_paid_local_table 'clickhouse-3' 2 1
create_uk_price_paid_local_table 'clickhouse-4' 2 2

clickhouse-client <<- "SQL"
  CREATE TABLE IF NOT EXISTS test.uk_price_paid
  ON CLUSTER my_cluster
  AS test.uk_price_paid_local ENGINE = Distributed(my_cluster, test, uk_price_paid_local, price)
SQL

echo "[CREATE TABLES: OK]"


echo "[DOWNLOAD DATA]"

[[ -f /datasets/uk_price_paid.csv ]] || (wget -O /datasets/uk_price_paid.csv http://prod.publicdata.landregistry.gov.uk.s3-website-eu-west-1.amazonaws.com/pp-complete.csv)

echo "[DOWNLOAD DATA: OK]"


echo "[TRUNCATE TABLES]"

echo "[TRUNCATE test.uk_price_paid...]"

clickhouse-client <<- "SQL"
  TRUNCATE TABLE test.uk_price_paid_local ON CLUSTER my_cluster
SQL

echo "[TRUNCATE TABLES: OK]"


echo "[INSERT DATA]"

echo "[INSERT TO test.uk_price_paid...]"
clickhouse-local --input-format CSV --structure '
    uuid String,
    price UInt32,
    time DateTime,
    postcode String,
    a String,
    b String,
    c String,
    addr1 String,
    addr2 String,
    street String,
    locality String,
    town String,
    district String,
    county String,
    d String,
    e String
' --query "
    WITH splitByChar(' ', postcode) AS p
    SELECT
        price,
        toDate(time) AS date,
        p[1] AS postcode1,
        p[2] AS postcode2,
        transform(a, ['T', 'S', 'D', 'F', 'O'], ['terraced', 'semi-detached', 'detached', 'flat', 'other']) AS type,
        b = 'Y' AS is_new,
        transform(c, ['F', 'L', 'U'], ['freehold', 'leasehold', 'unknown']) AS duration,
        addr1,
        addr2,
        street,
        locality,
        town,
        district,
        county,
        d = 'B' AS category
    FROM table" --date_time_input_format best_effort < /datasets/uk_price_paid.csv | clickhouse-client --query "INSERT INTO test.uk_price_paid FORMAT TSV"

echo "[INSERT DATA: OK]"


echo "[OPTIMIZE TABLES]"

echo "[OPTIMIZE test.uk_price_paid...]"

clickhouse-client <<- "SQL"
  OPTIMIZE TABLE test.uk_price_paid_local ON CLUSTER my_cluster FINAL
SQL

echo "[OPTIMIZE TABLES: OK]"


echo "[TABLES COUNT]"

echo "[COUNT test.uk_price_paid]"
clickhouse-client <<- "SQL"
  SELECT COUNT(*) FROM test.uk_price_paid
SQL

echo "[TABLES COUNT: OK]"


echo "[SYSTEM PARTS]"

function system_parts() {
  clickhouse-client -h "$1" <<- "SQL"
    SELECT
        table,
        partition,
        name,
        rows,
        disk_name
    FROM system.parts;
SQL
}

echo "[SYSTEM PARTS ON clickhouse-1]"
system_parts 'clickhouse-1'

echo "[SYSTEM PARTS ON clickhouse-2]"
system_parts 'clickhouse-2'

echo "[SYSTEM PARTS ON clickhouse-3]"
system_parts 'clickhouse-3'

echo "[SYSTEM PARTS ON clickhouse-4]"
system_parts 'clickhouse-4'

echo "[SYSTEM PARTS: OK]"
