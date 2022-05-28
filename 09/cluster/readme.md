# Clickhouse cluster test

## Тестовые данные
- Таблица `test.uk_price_paid`, 27094923 строк, [документация 1](https://clickhouse.com/docs/en/getting-started/example-datasets/uk-price-paid), [документация 2](https://www.gov.uk/government/statistical-data-sets/price-paid-data-downloads), [источник](http://prod.publicdata.landregistry.gov.uk.s3-website-eu-west-1.amazonaws.com/pp-complete.csv).
- Таблица `mgbench.logs1`, 22023859 строк, [документация](https://clickhouse.com/docs/en/getting-started/example-datasets/brown-benchmark/), [источник](https://datasets.clickhouse.com/mgbench1.csv.xz).
- Таблица `mgbench.logs2`, 75748118 строк, [документация](https://clickhouse.com/docs/en/getting-started/example-datasets/brown-benchmark/), [источник](https://datasets.clickhouse.com/mgbench2.csv.xz).
- Таблица `mgbench.logs3`, 108957039 строк, [документация](https://clickhouse.com/docs/en/getting-started/example-datasets/brown-benchmark/), [источник](https://datasets.clickhouse.com/mgbench3.csv.xz).

## Тестовая среда

**Clickhouse 21.3.20**, кластер с 2 shards, в каждом shard 2 replicas.

Сборка:
````bash
docker-compose up -d
````

Инициализация данных:
````bash
docker-compose exec clickhouse-1 ./init.sh
````

Запуск теста:
````bash
docker-compose exec clickhouse ./test.sh
````

Очистка:
````bash
docker-compose down -v
````

## Пример вывода

Инициализация данных:
````bash
[CREATE DATABASES]
clickhouse-2    9000    0               3       0
clickhouse-4    9000    0               2       0
clickhouse-3    9000    0               1       0
clickhouse-1    9000    0               0       0
[CREATE DATABASES: OK]
[CREATE TABLES]
clickhouse-2    9000    0               3       0
clickhouse-4    9000    0               2       0
clickhouse-3    9000    0               1       0
clickhouse-1    9000    0               0       0
[CREATE TABLES: OK]
[DOWNLOAD DATA]
[DOWNLOAD DATA: OK]
[TRUNCATE TABLES]
[TRUNCATE test.uk_price_paid...]
clickhouse-3    9000    0               3       2
clickhouse-2    9000    0               2       0
clickhouse-4    9000    0               1       0
clickhouse-1    9000    0               0       0
[TRUNCATE TABLES: OK]
[INSERT DATA]
[INSERT TO test.uk_price_paid...]
[INSERT DATA: OK]
[OPTIMIZE TABLES]
[OPTIMIZE test.uk_price_paid...]
clickhouse-2    9000    0               3       2
clickhouse-1    9000    0               2       2
clickhouse-4    9000    0               1       0
clickhouse-3    9000    0               0       0
[OPTIMIZE TABLES: OK]
[TABLES COUNT]
[COUNT test.uk_price_paid]
27094923
[TABLES COUNT: OK]
[SYSTEM PARTS]
[SYSTEM PARTS ON clickhouse-1]
// ...
uk_price_paid_local     tuple() all_29_29_0     1090397 default
uk_price_paid_local     tuple() all_29_34_1     6288090 default
uk_price_paid_local     tuple() all_30_30_0     1077958 default
uk_price_paid_local     tuple() all_31_31_0     1076171 default
uk_price_paid_local     tuple() all_32_32_0     1007427 default
uk_price_paid_local     tuple() all_33_33_0     1027913 default
uk_price_paid_local     tuple() all_34_34_0     1008224 default
uk_price_paid_local     tuple() all_35_35_0     1064638 default
uk_price_paid_local     tuple() all_35_40_1     6372939 default
uk_price_paid_local     tuple() all_36_36_0     1057496 default
uk_price_paid_local     tuple() all_37_37_0     1061037 default
uk_price_paid_local     tuple() all_38_38_0     1059125 default
uk_price_paid_local     tuple() all_39_39_0     1067104 default
uk_price_paid_local     tuple() all_40_40_0     1063539 default
uk_price_paid_local     tuple() all_41_41_0     1055763 default
uk_price_paid_local     tuple() all_41_46_1     6198325 default
uk_price_paid_local     tuple() all_42_42_0     1056482 default
uk_price_paid_local     tuple() all_43_43_0     1019658 default
uk_price_paid_local     tuple() all_44_44_0     1027734 default
uk_price_paid_local     tuple() all_45_45_0     1023748 default
uk_price_paid_local     tuple() all_46_46_0     1014940 default
uk_price_paid_local     tuple() all_47_47_0     1008200 default
uk_price_paid_local     tuple() all_48_48_0     1001209 default
uk_price_paid_local     tuple() all_49_49_0     997490  default
uk_price_paid_local     tuple() all_50_50_0     996545  default
uk_price_paid_local     tuple() all_51_51_0     993566  default
uk_price_paid_local     tuple() all_52_52_0     1003295 default
uk_price_paid_local     tuple() all_53_53_0     1031774 default
uk_price_paid_local     tuple() all_54_54_0     6539    default
[SYSTEM PARTS ON clickhouse-2]
// ...
uk_price_paid_local     tuple() all_29_29_0     1090397 default
uk_price_paid_local     tuple() all_29_34_1     6288090 default
uk_price_paid_local     tuple() all_30_30_0     1077958 default
uk_price_paid_local     tuple() all_31_31_0     1076171 default
uk_price_paid_local     tuple() all_32_32_0     1007427 default
uk_price_paid_local     tuple() all_33_33_0     1027913 default
uk_price_paid_local     tuple() all_34_34_0     1008224 default
uk_price_paid_local     tuple() all_35_35_0     1064638 default
uk_price_paid_local     tuple() all_35_40_1     6372939 default
uk_price_paid_local     tuple() all_36_36_0     1057496 default
uk_price_paid_local     tuple() all_37_37_0     1061037 default
uk_price_paid_local     tuple() all_38_38_0     1059125 default
uk_price_paid_local     tuple() all_39_39_0     1067104 default
uk_price_paid_local     tuple() all_40_40_0     1063539 default
uk_price_paid_local     tuple() all_41_41_0     1055763 default
uk_price_paid_local     tuple() all_41_46_1     6198325 default
uk_price_paid_local     tuple() all_42_42_0     1056482 default
uk_price_paid_local     tuple() all_43_43_0     1019658 default
uk_price_paid_local     tuple() all_44_44_0     1027734 default
uk_price_paid_local     tuple() all_45_45_0     1023748 default
uk_price_paid_local     tuple() all_46_46_0     1014940 default
uk_price_paid_local     tuple() all_47_47_0     1008200 default
uk_price_paid_local     tuple() all_48_48_0     1001209 default
uk_price_paid_local     tuple() all_49_49_0     997490  default
uk_price_paid_local     tuple() all_50_50_0     996545  default
uk_price_paid_local     tuple() all_51_51_0     993566  default
uk_price_paid_local     tuple() all_52_52_0     1003295 default
uk_price_paid_local     tuple() all_53_53_0     1031774 default
uk_price_paid_local     tuple() all_54_54_0     6539    default
[SYSTEM PARTS ON clickhouse-3]
// ...
uk_price_paid_local     tuple() all_29_29_0     41281   default
uk_price_paid_local     tuple() all_29_34_1     273691  default
uk_price_paid_local     tuple() all_29_45_2     795184  default
uk_price_paid_local     tuple() all_29_54_3     1196951 default
uk_price_paid_local     tuple() all_30_30_0     43103   default
uk_price_paid_local     tuple() all_31_31_0     45109   default
uk_price_paid_local     tuple() all_32_32_0     44491   default
uk_price_paid_local     tuple() all_33_33_0     49508   default
uk_price_paid_local     tuple() all_34_34_0     50199   default
uk_price_paid_local     tuple() all_35_35_0     50991   default
uk_price_paid_local     tuple() all_35_40_1     308652  default
uk_price_paid_local     tuple() all_36_36_0     56577   default
uk_price_paid_local     tuple() all_37_37_0     50797   default
uk_price_paid_local     tuple() all_38_38_0     51275   default
uk_price_paid_local     tuple() all_39_39_0     49271   default
uk_price_paid_local     tuple() all_40_40_0     49741   default
uk_price_paid_local     tuple() all_41_41_0     53612   default
uk_price_paid_local     tuple() all_42_42_0     50923   default
uk_price_paid_local     tuple() all_43_43_0     33864   default
uk_price_paid_local     tuple() all_44_44_0     35470   default
uk_price_paid_local     tuple() all_45_45_0     38972   default
uk_price_paid_local     tuple() all_46_46_0     46177   default
uk_price_paid_local     tuple() all_46_51_1     332082  default
uk_price_paid_local     tuple() all_47_47_0     52085   default
uk_price_paid_local     tuple() all_48_48_0     56240   default
uk_price_paid_local     tuple() all_49_49_0     58999   default
uk_price_paid_local     tuple() all_50_50_0     59506   default
uk_price_paid_local     tuple() all_51_51_0     59075   default
uk_price_paid_local     tuple() all_52_52_0     48567   default
uk_price_paid_local     tuple() all_53_53_0     21040   default
uk_price_paid_local     tuple() all_54_54_0     78      default
[SYSTEM PARTS ON clickhouse-4]
// ...
uk_price_paid_local     tuple() all_29_29_0     41281   default
uk_price_paid_local     tuple() all_29_34_1     273691  default
uk_price_paid_local     tuple() all_29_45_2     795184  default
uk_price_paid_local     tuple() all_29_54_3     1196951 default
uk_price_paid_local     tuple() all_30_30_0     43103   default
uk_price_paid_local     tuple() all_31_31_0     45109   default
uk_price_paid_local     tuple() all_32_32_0     44491   default
uk_price_paid_local     tuple() all_33_33_0     49508   default
uk_price_paid_local     tuple() all_34_34_0     50199   default
uk_price_paid_local     tuple() all_35_35_0     50991   default
uk_price_paid_local     tuple() all_35_40_1     308652  default
uk_price_paid_local     tuple() all_36_36_0     56577   default
uk_price_paid_local     tuple() all_37_37_0     50797   default
uk_price_paid_local     tuple() all_38_38_0     51275   default
uk_price_paid_local     tuple() all_39_39_0     49271   default
uk_price_paid_local     tuple() all_40_40_0     49741   default
uk_price_paid_local     tuple() all_41_41_0     53612   default
uk_price_paid_local     tuple() all_42_42_0     50923   default
uk_price_paid_local     tuple() all_43_43_0     33864   default
uk_price_paid_local     tuple() all_44_44_0     35470   default
uk_price_paid_local     tuple() all_45_45_0     38972   default
uk_price_paid_local     tuple() all_46_46_0     46177   default
uk_price_paid_local     tuple() all_46_51_1     332082  default
uk_price_paid_local     tuple() all_47_47_0     52085   default
uk_price_paid_local     tuple() all_48_48_0     56240   default
uk_price_paid_local     tuple() all_49_49_0     58999   default
uk_price_paid_local     tuple() all_50_50_0     59506   default
uk_price_paid_local     tuple() all_51_51_0     59075   default
uk_price_paid_local     tuple() all_52_52_0     48567   default
uk_price_paid_local     tuple() all_53_53_0     21040   default
uk_price_paid_local     tuple() all_54_54_0     78      default
[SYSTEM PARTS: OK]
````

Тест:
````bash
=== Execute query: 
  SELECT COUNT(*)
  FROM test.uk_price_paid

= Query result: 
27094923
= Query time ms: 0.008
======================================================

=== Execute query: 
  SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 1000000, 80)
  FROM test.uk_price_paid
  GROUP BY year
  ORDER BY year

= Query result: 
1995    67932   █████▍
1996    71507   █████▋
1997    78536   ██████▎
1998    85438   ██████▋
1999    96038   ███████▋
2000    107485  ████████▌
2001    118888  █████████▌
2002    137945  ███████████
2003    155892  ████████████▍
2004    178887  ██████████████▎
2005    189356  ███████████████▏
2006    203529  ████████████████▎
2007    219379  █████████████████▌
2008    217055  █████████████████▎
2009    213418  █████████████████
2010    236108  ██████████████████▊
2011    232803  ██████████████████▌
2012    238382  ███████████████████
2013    256921  ████████████████████▌
2014    279955  ██████████████████████▍
2015    297263  ███████████████████████▋
2016    313463  █████████████████████████
2017    346233  ███████████████████████████▋
2018    350455  ████████████████████████████
2019    351967  ████████████████████████████▏
2020    375457  ██████████████████████████████
2021    381448  ██████████████████████████████▌
2022    374316  █████████████████████████████▊
= Query time ms: 0.436
======================================================

=== Execute query: 
  SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 2000000, 100)
  FROM test.uk_price_paid
  WHERE town = 'LONDON'
  GROUP BY year
  ORDER BY year

= Query result: 
1995    109109  █████▍
1996    118659  █████▊
1997    136528  ██████▋
1998    152985  ███████▋
1999    180635  █████████
2000    215835  ██████████▋
2001    232992  ███████████▋
2002    263663  █████████████▏
2003    278420  █████████████▊
2004    304665  ███████████████▏
2005    322884  ████████████████▏
2006    356184  █████████████████▋
2007    404064  ████████████████████▏
2008    420745  █████████████████████
2009    427754  █████████████████████▍
2010    480302  ████████████████████████
2011    496255  ████████████████████████▋
2012    519490  █████████████████████████▊
2013    616183  ██████████████████████████████▋
2014    724126  ████████████████████████████████████▏
2015    792110  ███████████████████████████████████████▌
2016    843612  ██████████████████████████████████████████▏
2017    982894  █████████████████████████████████████████████████▏
2018    1016678 ██████████████████████████████████████████████████▋
2019    1042348 ████████████████████████████████████████████████████
2020    1067639 █████████████████████████████████████████████████████▍
2021    951766  ███████████████████████████████████████████████▌
2022    915046  █████████████████████████████████████████████▋
= Query time ms: 0.143
======================================================

=== Execute query: 
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

= Query result: 
LONDON  CITY OF LONDON  475     3371649 ███████████████████████████████████████████████████████████████████▍
LONDON  CITY OF WESTMINSTER     6008    3007201 ████████████████████████████████████████████████████████████▏
LONDON  KENSINGTON AND CHELSEA  4147    2327026 ██████████████████████████████████████████████▌
LEATHERHEAD     ELMBRIDGE       179     2001055 ████████████████████████████████████████
VIRGINIA WATER  RUNNYMEDE       273     1978847 ███████████████████████████████████████▌
LONDON  CAMDEN  4925    1736541 ██████████████████████████████████▋
WINDLESHAM      SURREY HEATH    160     1433947 ████████████████████████████▋
BARNET  ENFIELD 223     1358235 ███████████████████████████▏
LONDON  ISLINGTON       4664    1290663 █████████████████████████▋
LONDON  RICHMOND UPON THAMES    1156    1262893 █████████████████████████▎
COBHAM  ELMBRIDGE       628     1244941 ████████████████████████▊
LONDON  TOWER HAMLETS   8173    1223487 ████████████████████████▍
KINGSTON UPON THAMES    RICHMOND UPON THAMES    126     1218421 ████████████████████████▎
LONDON  HOUNSLOW        1086    1209520 ████████████████████████▏
BEACONSFIELD    BUCKINGHAMSHIRE 569     1194710 ███████████████████████▊
BURFORD WEST OXFORDSHIRE        161     1184937 ███████████████████████▋
ASCOT   WINDSOR AND MAIDENHEAD  659     1149918 ██████████████████████▊
RICHMOND        RICHMOND UPON THAMES    1364    1127422 ██████████████████████▌
THORNTON HEATH  CROYDON 904     1125871 ██████████████████████▌
RADLETT HERTSMERE       437     1056585 █████████████████████▏
LONDON  HAMMERSMITH AND FULHAM  5157    1055217 █████████████████████
WEYBRIDGE       ELMBRIDGE       1116    1041124 ████████████████████▋
ROWLAND\'S CASTLE       EAST HAMPSHIRE  150     1039456 ████████████████████▋
ESHER   ELMBRIDGE       786     1008119 ████████████████████▏
LEATHERHEAD     GUILDFORD       299     1005199 ████████████████████
GERRARDS CROSS  BUCKINGHAMSHIRE 709     973985  ███████████████████▍
SALCOMBE        SOUTH HAMS      191     972283  ███████████████████▍
CHALFONT ST GILES       BUCKINGHAMSHIRE 250     965256  ███████████████████▎
OXFORD  SOUTH OXFORDSHIRE       552     960366  ███████████████████▏
SURBITON        ELMBRIDGE       163     953353  ███████████████████
BROCKENHURST    NEW FOREST      189     936857  ██████████████████▋
EAST MOLESEY    ELMBRIDGE       315     930450  ██████████████████▌
SUTTON COLDFIELD        LICHFIELD       101     925126  ██████████████████▌
LUTTERWORTH     HARBOROUGH      946     910071  ██████████████████▏
GUILDFORD       WAVERLEY        229     898231  █████████████████▊
HENLEY-ON-THAMES        SOUTH OXFORDSHIRE       908     893214  █████████████████▋
LONDON  MERTON  3685    892879  █████████████████▋
STROUD  STROUD  1990    890108  █████████████████▋
HARPENDEN       ST ALBANS       1080    885716  █████████████████▋
POTTERS BAR     WELWYN HATFIELD 277     876123  █████████████████▌
LONDON  SOUTHWARK       6542    850549  █████████████████
INGATESTONE     CHELMSFORD      103     849282  ████████████████▊
KINGSTON UPON THAMES    KINGSTON UPON THAMES    1581    847797  ████████████████▊
LONDON  WANDSWORTH      11005   844604  ████████████████▊
HINDHEAD        WAVERLEY        196     836764  ████████████████▋
LONDON  HACKNEY 5533    827645  ████████████████▌
LONDON  EALING  4646    823130  ████████████████▍
BILLINGSHURST   CHICHESTER      216     822967  ████████████████▍
BELVEDERE       BEXLEY  565     822620  ████████████████▍
PETWORTH        CHICHESTER      247     820003  ████████████████▍
TWICKENHAM      RICHMOND UPON THAMES    1878    808930  ████████████████▏
WOKING  GUILDFORD       292     805417  ████████████████
HASLEMERE       CHICHESTER      196     802838  ████████████████
MARLOW  BUCKINGHAMSHIRE 607     796349  ███████████████▊
TEDDINGTON      RICHMOND UPON THAMES    981     785317  ███████████████▋
CHIGWELL        EPPING FOREST   433     784085  ███████████████▋
LECHLADE        COTSWOLD        133     778143  ███████████████▌
BERKHAMSTED     DACORUM 926     777883  ███████████████▌
STOCKBRIDGE     TEST VALLEY     282     770332  ███████████████▍
WEMBLEY BRENT   1441    769263  ███████████████▍
LONDON  BARNET  6875    764242  ███████████████▎
GREAT MISSENDEN BUCKINGHAMSHIRE 372     764212  ███████████████▎
KINGS LANGLEY   DACORUM 240     761477  ███████████████▏
CRANBROOK       TUNBRIDGE WELLS 674     761297  ███████████████▏
FELTHAM HOUNSLOW        1295    760172  ███████████████▏
LONDON  LAMBETH 8777    756135  ███████████████
LONDON  BRENT   3509    750668  ███████████████
MAIDENHEAD      BUCKINGHAMSHIRE 198     744692  ██████████████▊
SOLIHULL        STRATFORD-ON-AVON       126     744117  ██████████████▊
SEVENOAKS       SEVENOAKS       1882    743607  ██████████████▋
ALDERLEY EDGE   CHESHIRE EAST   305     741488  ██████████████▋
BOURNE END      BUCKINGHAMSHIRE 213     739758  ██████████████▋
TADWORTH        REIGATE AND BANSTEAD    783     739528  ██████████████▋
TUNBRIDGE WELLS WEALDEN 165     736299  ██████████████▋
THAMES DITTON   ELMBRIDGE       383     732898  ██████████████▋
OLNEY   MILTON KEYNES   394     732506  ██████████████▋
LONDON  HARINGEY        5443    732202  ██████████████▋
AMERSHAM        BUCKINGHAMSHIRE 829     731739  ██████████████▋
HARLOW  EPPING FOREST   149     730528  ██████████████▌
HOVE    BRIGHTON AND HOVE       3285    729864  ██████████████▌
RICKMANSWORTH   THREE RIVERS    1248    729574  ██████████████▌
LYNDHURST       NEW FOREST      161     728555  ██████████████▌
EPSOM   REIGATE AND BANSTEAD    262     726121  ██████████████▌
PURFLEET        THURROCK        142     725618  ██████████████▌
WELWYN  WELWYN HATFIELD 357     722427  ██████████████▍
SLOUGH  BUCKINGHAMSHIRE 700     721638  ██████████████▍
OXTED   TANDRIDGE       518     715580  ██████████████▎
CHISLEHURST     BROMLEY 737     715303  ██████████████▎
OXFORD  VALE OF WHITE HORSE     577     713542  ██████████████▎
MIDHURST        CHICHESTER      396     710139  ██████████████▏
BETCHWORTH      MOLE VALLEY     136     704515  ██████████████
NORTHWOOD       HILLINGDON      471     703612  ██████████████
WALTON-ON-THAMES        ELMBRIDGE       1603    703390  ██████████████
INGATESTONE     BRENTWOOD       263     701469  ██████████████
ASHTEAD MOLE VALLEY     471     701356  ██████████████
WOODSTOCK       WEST OXFORDSHIRE        238     698660  █████████████▊
READING SOUTH OXFORDSHIRE       500     697317  █████████████▊
WADHURST        WEALDEN 210     696545  █████████████▊
LEWES   WEALDEN 101     694007  █████████████▊
PINNER  HARROW  851     692770  █████████████▋
= Query time ms: 0.140
======================================================
````

## Сравнение результата cluster c single instance

| Query                 | single instance | cluster  |
|-----------------------|-----------------|----------|
| #1 test.uk_price_paid | 0.004 ms        | 0.008 ms |
| #2 test.uk_price_paid | 0.096 ms        | 0.436 ms |
| #3 test.uk_price_paid | 0.038 ms        | 0.143 ms |
| #4 test.uk_price_paid | 0.099 ms        | 0.140 ms |