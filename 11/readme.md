# Neo4j vs RDBMS

### Простые запросы

При простых запросах разницы особой нет, например:

````
match (:Director {name: 'Joel Coen'})
````

````postgresql
SELECT * FROM directors WHERE name = 'Joel Coen'
````

### Запросы с соединениями

Чем больше соединений, тем больше JOIN в RDBMS и чем проще кажется запрос в Neo4j, например:

````
match (d:Director) -[r]- (m:Movie) return d, r, m
````

````postgresql
SELECT d.*, r.*, m.* FROM directors d
    INNER JOIN director_movie r ON d.id = r.director_id
    INNER JOIN movies m ON r.movie_id = m.id
````
При таком запросе в результате могут быть повторяющиеся данные (например, тот же *director* или *movie*). Для ухода от такой ситуации запрос можно разделить на несколько, например, получить сначала связи из `director_movie`, затем на основе результата получить каждые `directors` и `movies` в единственном экземпляре.
