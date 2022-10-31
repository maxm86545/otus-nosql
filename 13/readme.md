# Neo4j test db index

## Добавить индексы

### Фильтрация по имени города
````cypher
CREATE INDEX сity
FOR (с:City)
ON (c.name)
````

### Фильтрация по связям с определенным типом транспорта
````cypher
CREATE INDEX way
FOR ()-[w:WAY]-()
ON (w.type)
````

## Удалить индексы

````cypher
DROP INDEX city
````

````cypher
DROP INDEX way
````

## Список индексов

````cypher
SHOW INDEXES
````
