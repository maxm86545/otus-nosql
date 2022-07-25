#!/bin/bash

set -e

echo "[CREATE DATABASES]"

clickhouse-client <<- "SQL"
  CREATE DATABASE IF NOT EXISTS tutorial
SQL

clickhouse-client <<- "SQL"
  CREATE DATABASE IF NOT EXISTS test
SQL

clickhouse-client <<- "SQL"
  CREATE DATABASE IF NOT EXISTS mgbench
SQL

echo "[CREATE DATABASES: OK]"


echo "[CREATE TABLES]"

clickhouse-client <<- "SQL"
  CREATE TABLE IF NOT EXISTS tutorial.hits_v1
  (
      `WatchID` UInt64,
      `JavaEnable` UInt8,
      `Title` String,
      `GoodEvent` Int16,
      `EventTime` DateTime,
      `EventDate` Date,
      `CounterID` UInt32,
      `ClientIP` UInt32,
      `ClientIP6` FixedString(16),
      `RegionID` UInt32,
      `UserID` UInt64,
      `CounterClass` Int8,
      `OS` UInt8,
      `UserAgent` UInt8,
      `URL` String,
      `Referer` String,
      `URLDomain` String,
      `RefererDomain` String,
      `Refresh` UInt8,
      `IsRobot` UInt8,
      `RefererCategories` Array(UInt16),
      `URLCategories` Array(UInt16),
      `URLRegions` Array(UInt32),
      `RefererRegions` Array(UInt32),
      `ResolutionWidth` UInt16,
      `ResolutionHeight` UInt16,
      `ResolutionDepth` UInt8,
      `FlashMajor` UInt8,
      `FlashMinor` UInt8,
      `FlashMinor2` String,
      `NetMajor` UInt8,
      `NetMinor` UInt8,
      `UserAgentMajor` UInt16,
      `UserAgentMinor` FixedString(2),
      `CookieEnable` UInt8,
      `JavascriptEnable` UInt8,
      `IsMobile` UInt8,
      `MobilePhone` UInt8,
      `MobilePhoneModel` String,
      `Params` String,
      `IPNetworkID` UInt32,
      `TraficSourceID` Int8,
      `SearchEngineID` UInt16,
      `SearchPhrase` String,
      `AdvEngineID` UInt8,
      `IsArtifical` UInt8,
      `WindowClientWidth` UInt16,
      `WindowClientHeight` UInt16,
      `ClientTimeZone` Int16,
      `ClientEventTime` DateTime,
      `SilverlightVersion1` UInt8,
      `SilverlightVersion2` UInt8,
      `SilverlightVersion3` UInt32,
      `SilverlightVersion4` UInt16,
      `PageCharset` String,
      `CodeVersion` UInt32,
      `IsLink` UInt8,
      `IsDownload` UInt8,
      `IsNotBounce` UInt8,
      `FUniqID` UInt64,
      `HID` UInt32,
      `IsOldCounter` UInt8,
      `IsEvent` UInt8,
      `IsParameter` UInt8,
      `DontCountHits` UInt8,
      `WithHash` UInt8,
      `HitColor` FixedString(1),
      `UTCEventTime` DateTime,
      `Age` UInt8,
      `Sex` UInt8,
      `Income` UInt8,
      `Interests` UInt16,
      `Robotness` UInt8,
      `GeneralInterests` Array(UInt16),
      `RemoteIP` UInt32,
      `RemoteIP6` FixedString(16),
      `WindowName` Int32,
      `OpenerName` Int32,
      `HistoryLength` Int16,
      `BrowserLanguage` FixedString(2),
      `BrowserCountry` FixedString(2),
      `SocialNetwork` String,
      `SocialAction` String,
      `HTTPError` UInt16,
      `SendTiming` Int32,
      `DNSTiming` Int32,
      `ConnectTiming` Int32,
      `ResponseStartTiming` Int32,
      `ResponseEndTiming` Int32,
      `FetchTiming` Int32,
      `RedirectTiming` Int32,
      `DOMInteractiveTiming` Int32,
      `DOMContentLoadedTiming` Int32,
      `DOMCompleteTiming` Int32,
      `LoadEventStartTiming` Int32,
      `LoadEventEndTiming` Int32,
      `NSToDOMContentLoadedTiming` Int32,
      `FirstPaintTiming` Int32,
      `RedirectCount` Int8,
      `SocialSourceNetworkID` UInt8,
      `SocialSourcePage` String,
      `ParamPrice` Int64,
      `ParamOrderID` String,
      `ParamCurrency` FixedString(3),
      `ParamCurrencyID` UInt16,
      `GoalsReached` Array(UInt32),
      `OpenstatServiceName` String,
      `OpenstatCampaignID` String,
      `OpenstatAdID` String,
      `OpenstatSourceID` String,
      `UTMSource` String,
      `UTMMedium` String,
      `UTMCampaign` String,
      `UTMContent` String,
      `UTMTerm` String,
      `FromTag` String,
      `HasGCLID` UInt8,
      `RefererHash` UInt64,
      `URLHash` UInt64,
      `CLID` UInt32,
      `YCLID` UInt64,
      `ShareService` String,
      `ShareURL` String,
      `ShareTitle` String,
      `ParsedParams` Nested(
          Key1 String,
          Key2 String,
          Key3 String,
          Key4 String,
          Key5 String,
          ValueDouble Float64),
      `IslandID` FixedString(16),
      `RequestNum` UInt32,
      `RequestTry` UInt8
  )
  ENGINE = MergeTree()
  PARTITION BY toYYYYMM(EventDate)
  ORDER BY (CounterID, EventDate, intHash32(UserID))
  SAMPLE BY intHash32(UserID)
SQL

clickhouse-client <<- "SQL"
  CREATE TABLE IF NOT EXISTS tutorial.visits_v1
  (
      `CounterID` UInt32,
      `StartDate` Date,
      `Sign` Int8,
      `IsNew` UInt8,
      `VisitID` UInt64,
      `UserID` UInt64,
      `StartTime` DateTime,
      `Duration` UInt32,
      `UTCStartTime` DateTime,
      `PageViews` Int32,
      `Hits` Int32,
      `IsBounce` UInt8,
      `Referer` String,
      `StartURL` String,
      `RefererDomain` String,
      `StartURLDomain` String,
      `EndURL` String,
      `LinkURL` String,
      `IsDownload` UInt8,
      `TraficSourceID` Int8,
      `SearchEngineID` UInt16,
      `SearchPhrase` String,
      `AdvEngineID` UInt8,
      `PlaceID` Int32,
      `RefererCategories` Array(UInt16),
      `URLCategories` Array(UInt16),
      `URLRegions` Array(UInt32),
      `RefererRegions` Array(UInt32),
      `IsYandex` UInt8,
      `GoalReachesDepth` Int32,
      `GoalReachesURL` Int32,
      `GoalReachesAny` Int32,
      `SocialSourceNetworkID` UInt8,
      `SocialSourcePage` String,
      `MobilePhoneModel` String,
      `ClientEventTime` DateTime,
      `RegionID` UInt32,
      `ClientIP` UInt32,
      `ClientIP6` FixedString(16),
      `RemoteIP` UInt32,
      `RemoteIP6` FixedString(16),
      `IPNetworkID` UInt32,
      `SilverlightVersion3` UInt32,
      `CodeVersion` UInt32,
      `ResolutionWidth` UInt16,
      `ResolutionHeight` UInt16,
      `UserAgentMajor` UInt16,
      `UserAgentMinor` UInt16,
      `WindowClientWidth` UInt16,
      `WindowClientHeight` UInt16,
      `SilverlightVersion2` UInt8,
      `SilverlightVersion4` UInt16,
      `FlashVersion3` UInt16,
      `FlashVersion4` UInt16,
      `ClientTimeZone` Int16,
      `OS` UInt8,
      `UserAgent` UInt8,
      `ResolutionDepth` UInt8,
      `FlashMajor` UInt8,
      `FlashMinor` UInt8,
      `NetMajor` UInt8,
      `NetMinor` UInt8,
      `MobilePhone` UInt8,
      `SilverlightVersion1` UInt8,
      `Age` UInt8,
      `Sex` UInt8,
      `Income` UInt8,
      `JavaEnable` UInt8,
      `CookieEnable` UInt8,
      `JavascriptEnable` UInt8,
      `IsMobile` UInt8,
      `BrowserLanguage` UInt16,
      `BrowserCountry` UInt16,
      `Interests` UInt16,
      `Robotness` UInt8,
      `GeneralInterests` Array(UInt16),
      `Params` Array(String),
      `Goals` Nested(
          ID UInt32,
          Serial UInt32,
          EventTime DateTime,
          Price Int64,
          OrderID String,
          CurrencyID UInt32),
      `WatchIDs` Array(UInt64),
      `ParamSumPrice` Int64,
      `ParamCurrency` FixedString(3),
      `ParamCurrencyID` UInt16,
      `ClickLogID` UInt64,
      `ClickEventID` Int32,
      `ClickGoodEvent` Int32,
      `ClickEventTime` DateTime,
      `ClickPriorityID` Int32,
      `ClickPhraseID` Int32,
      `ClickPageID` Int32,
      `ClickPlaceID` Int32,
      `ClickTypeID` Int32,
      `ClickResourceID` Int32,
      `ClickCost` UInt32,
      `ClickClientIP` UInt32,
      `ClickDomainID` UInt32,
      `ClickURL` String,
      `ClickAttempt` UInt8,
      `ClickOrderID` UInt32,
      `ClickBannerID` UInt32,
      `ClickMarketCategoryID` UInt32,
      `ClickMarketPP` UInt32,
      `ClickMarketCategoryName` String,
      `ClickMarketPPName` String,
      `ClickAWAPSCampaignName` String,
      `ClickPageName` String,
      `ClickTargetType` UInt16,
      `ClickTargetPhraseID` UInt64,
      `ClickContextType` UInt8,
      `ClickSelectType` Int8,
      `ClickOptions` String,
      `ClickGroupBannerID` Int32,
      `OpenstatServiceName` String,
      `OpenstatCampaignID` String,
      `OpenstatAdID` String,
      `OpenstatSourceID` String,
      `UTMSource` String,
      `UTMMedium` String,
      `UTMCampaign` String,
      `UTMContent` String,
      `UTMTerm` String,
      `FromTag` String,
      `HasGCLID` UInt8,
      `FirstVisit` DateTime,
      `PredLastVisit` Date,
      `LastVisit` Date,
      `TotalVisits` UInt32,
      `TraficSource` Nested(
          ID Int8,
          SearchEngineID UInt16,
          AdvEngineID UInt8,
          PlaceID UInt16,
          SocialSourceNetworkID UInt8,
          Domain String,
          SearchPhrase String,
          SocialSourcePage String),
      `Attendance` FixedString(16),
      `CLID` UInt32,
      `YCLID` UInt64,
      `NormalizedRefererHash` UInt64,
      `SearchPhraseHash` UInt64,
      `RefererDomainHash` UInt64,
      `NormalizedStartURLHash` UInt64,
      `StartURLDomainHash` UInt64,
      `NormalizedEndURLHash` UInt64,
      `TopLevelDomain` UInt64,
      `URLScheme` UInt64,
      `OpenstatServiceNameHash` UInt64,
      `OpenstatCampaignIDHash` UInt64,
      `OpenstatAdIDHash` UInt64,
      `OpenstatSourceIDHash` UInt64,
      `UTMSourceHash` UInt64,
      `UTMMediumHash` UInt64,
      `UTMCampaignHash` UInt64,
      `UTMContentHash` UInt64,
      `UTMTermHash` UInt64,
      `FromHash` UInt64,
      `WebVisorEnabled` UInt8,
      `WebVisorActivity` UInt32,
      `ParsedParams` Nested(
          Key1 String,
          Key2 String,
          Key3 String,
          Key4 String,
          Key5 String,
          ValueDouble Float64),
      `Market` Nested(
          Type UInt8,
          GoalID UInt32,
          OrderID String,
          OrderPrice Int64,
          PP UInt32,
          DirectPlaceID UInt32,
          DirectOrderID UInt32,
          DirectBannerID UInt32,
          GoodID String,
          GoodName String,
          GoodQuantity Int32,
          GoodPrice Int64),
      `IslandID` FixedString(16)
  )
  ENGINE = CollapsingMergeTree(Sign)
  PARTITION BY toYYYYMM(StartDate)
  ORDER BY (CounterID, StartDate, intHash32(UserID), VisitID)
  SAMPLE BY intHash32(UserID)
SQL

clickhouse-client <<- "SQL"
  CREATE TABLE IF NOT EXISTS test.uk_price_paid
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
  ) ENGINE = MergeTree ORDER BY (postcode1, postcode2, addr1, addr2);
SQL

clickhouse-client <<- "SQL"
  CREATE TABLE IF NOT EXISTS mgbench.logs1 (
     log_time      DateTime,
     machine_name  LowCardinality(String),
     machine_group LowCardinality(String),
     cpu_idle      Nullable(Float32),
     cpu_nice      Nullable(Float32),
     cpu_system    Nullable(Float32),
     cpu_user      Nullable(Float32),
     cpu_wio       Nullable(Float32),
     disk_free     Nullable(Float32),
     disk_total    Nullable(Float32),
     part_max_used Nullable(Float32),
     load_fifteen  Nullable(Float32),
     load_five     Nullable(Float32),
     load_one      Nullable(Float32),
     mem_buffers   Nullable(Float32),
     mem_cached    Nullable(Float32),
     mem_free      Nullable(Float32),
     mem_shared    Nullable(Float32),
     swap_free     Nullable(Float32),
     bytes_in      Nullable(Float32),
     bytes_out     Nullable(Float32)
 )
 ENGINE = MergeTree()
 ORDER BY (machine_group, machine_name, log_time);
SQL

clickhouse-client <<- "SQL"
  CREATE TABLE IF NOT EXISTS mgbench.logs2 (
      log_time    DateTime,
      client_ip   IPv4,
      request     String,
      status_code UInt16,
      object_size UInt64
  )
  ENGINE = MergeTree()
  ORDER BY log_time;
SQL

clickhouse-client <<- "SQL"
  CREATE TABLE IF NOT EXISTS mgbench.logs3 (
      log_time     DateTime64,
      device_id    FixedString(15),
      device_name  LowCardinality(String),
      device_type  LowCardinality(String),
      device_floor UInt8,
      event_type   LowCardinality(String),
      event_unit   FixedString(1),
      event_value  Nullable(Float32)
  )
  ENGINE = MergeTree()
  ORDER BY (event_type, log_time);
SQL

echo "[CREATE TABLES: OK]"


echo "[DOWNLOAD DATA]"

[[ -f /datasets/hits_v1.tsv ]] || (wget -O- https://datasets.clickhouse.com/hits/tsv/hits_v1.tsv.xz | unxz > /datasets/hits_v1.tsv)
[[ -f /datasets/visits_v1.tsv ]] || (wget -O- https://datasets.clickhouse.com/visits/tsv/visits_v1.tsv.xz | unxz > /datasets/visits_v1.tsv)
[[ -f /datasets/uk_price_paid.csv ]] || (wget -O /datasets/uk_price_paid.csv http://prod.publicdata.landregistry.gov.uk.s3-website-eu-west-1.amazonaws.com/pp-complete.csv)
[[ -f /datasets/mgbench1.csv ]] || (wget -O- https://datasets.clickhouse.com/mgbench1.csv.xz | unxz > /datasets/mgbench1.csv)
[[ -f /datasets/mgbench2.csv ]] || (wget -O- https://datasets.clickhouse.com/mgbench2.csv.xz | unxz > /datasets/mgbench2.csv)
[[ -f /datasets/mgbench3.csv ]] || (wget -O- https://datasets.clickhouse.com/mgbench3.csv.xz | unxz > /datasets/mgbench3.csv)

echo "[DOWNLOAD DATA: OK]"


echo "[TRUNCATE TABLES]"

echo "[TRUNCATE tutorial.hits_v1...]"
clickhouse-client <<- "SQL"
  TRUNCATE TABLE tutorial.hits_v1
SQL

echo "[TRUNCATE tutorial.visits_v1...]"
clickhouse-client <<- "SQL"
  TRUNCATE TABLE tutorial.visits_v1
SQL

echo "[TRUNCATE test.uk_price_paid...]"
clickhouse-client <<- "SQL"
  TRUNCATE TABLE test.uk_price_paid
SQL

echo "[TRUNCATE mgbench.logs1...]"
clickhouse-client <<- "SQL"
  TRUNCATE TABLE mgbench.logs1
SQL

echo "[TRUNCATE mgbench.logs2...]"
clickhouse-client <<- "SQL"
  TRUNCATE TABLE mgbench.logs2
SQL

echo "[TRUNCATE mgbench.logs3...]"
clickhouse-client <<- "SQL"
  TRUNCATE TABLE mgbench.logs3
SQL

echo "[TRUNCATE TABLES: OK]"


echo "[INSERT DATA]"

echo "[INSERT TO tutorial.hits_v1...]"
clickhouse-client --query "INSERT INTO tutorial.hits_v1 FORMAT TSV" --max_insert_block_size=100000 < /datasets/hits_v1.tsv

echo "[INSERT TO tutorial.visits_v1...]"
clickhouse-client --query "INSERT INTO tutorial.visits_v1 FORMAT TSV" --max_insert_block_size=100000 < /datasets/visits_v1.tsv

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

echo "[INSERT TO mgbench.logs1...]"
clickhouse-client --query "INSERT INTO mgbench.logs1 FORMAT CSVWithNames" --max_insert_block_size=100000 < /datasets/mgbench1.csv

echo "[INSERT TO mgbench.logs2...]"
clickhouse-client --query "INSERT INTO mgbench.logs2 FORMAT CSVWithNames" --max_insert_block_size=100000 < /datasets/mgbench2.csv

echo "[INSERT TO mgbench.logs3...]"
clickhouse-client --query "INSERT INTO mgbench.logs3 FORMAT CSVWithNames" --max_insert_block_size=100000 < /datasets/mgbench3.csv

echo "[INSERT DATA: OK]"


echo "[OPTIMIZE TABLES]"

echo "[OPTIMIZE tutorial.hits_v1...]"
clickhouse-client <<- "SQL"
  OPTIMIZE TABLE tutorial.hits_v1 FINAL
SQL

echo "[OPTIMIZE tutorial.visits_v1...]"
clickhouse-client <<- "SQL"
  OPTIMIZE TABLE tutorial.visits_v1 FINAL
SQL

echo "[OPTIMIZE test.uk_price_paid...]"
clickhouse-client <<- "SQL"
  OPTIMIZE TABLE test.uk_price_paid FINAL
SQL

echo "[OPTIMIZE mgbench.logs1...]"
clickhouse-client <<- "SQL"
  OPTIMIZE TABLE mgbench.logs1 FINAL
SQL

echo "[OPTIMIZE mgbench.logs2...]"
clickhouse-client <<- "SQL"
  OPTIMIZE TABLE mgbench.logs2 FINAL
SQL

echo "[OPTIMIZE mgbench.logs3...]"
clickhouse-client <<- "SQL"
  OPTIMIZE TABLE mgbench.logs3 FINAL
SQL

echo "[OPTIMIZE TABLES: OK]"


echo "[TABLES COUNT]"

echo "[COUNT tutorial.hits_v1]"
clickhouse-client <<- "SQL"
  SELECT COUNT(*) FROM tutorial.hits_v1
SQL

echo "[COUNT tutorial.visits_v1]"
clickhouse-client <<- "SQL"
  SELECT COUNT(*) FROM tutorial.visits_v1
SQL

echo "[COUNT tutorial.uk_price_paid]"
clickhouse-client <<- "SQL"
  SELECT COUNT(*) FROM test.uk_price_paid
SQL

echo "[COUNT mgbench.logs1]"
clickhouse-client <<- "SQL"
  SELECT COUNT(*) FROM mgbench.logs1
SQL

echo "[COUNT mgbench.logs2]"
clickhouse-client <<- "SQL"
  SELECT COUNT(*) FROM mgbench.logs2
SQL

echo "[COUNT mgbench.logs3]"
clickhouse-client <<- "SQL"
  SELECT COUNT(*) FROM mgbench.logs3
SQL

echo "[TABLES COUNT: OK]"
