# Neo4j test db

## Наполнение

````cypher
CREATE (o1:Operator {name:'Operator 1'}), (o2:Operator {name:'Operator 2'}), (o3:Operator {name:'Operator 3'}), (o4:Operator {name:'Operator 4'}), (o5:Operator {name:'Operator 5'})
CREATE (c1:Country {name:'Турция'}), (c2:Country {name:'Египет'}), (c3:Country {name:'Тунис'}), (c4:Country {name:'Франция'}), (c5:Country {name:'Италия'}), (c6:Country {name:'Болгария'}), (c7:Country {name:'Испания'}), (c8:Country {name:'Швеция'}), (c9:Country {name:'Германия'}), (c10:Country {name:'Польша'})
CREATE (ci1:City {name:'Анкара'})-[:IN]->(c1), (ci2:City {name:'Каир'})-[:IN]->(c2), (ci3:City {name:'Тунис'})-[:IN]->(c3), (ci4:City {name:'Канны'})-[:IN]->(c4), (ci5:City {name:'Венеция'})-[:IN]->(c5), (ci6:City {name:'Несебр'})-[:IN]->(c6), (ci7:City {name:'Ибица'})-[:IN]->(c7), (ci8:City {name:'Стокгольм'})-[:IN]->(c8), (ci9:City {name:'Берлин'})-[:IN]->(c9), (ci10:City {name:'Гданьск'})-[:IN]->(c10)
CREATE (r1:Resort {name:'Турция 1'})-[:IN]->(ci1), (r2:Resort {name:'Египет 1'})-[:IN]->(ci2), (r3:Resort {name:'Тунис 1'})-[:IN]->(ci3), (r4:Resort {name:'Франция 1'})-[:IN]->(ci4), (r5:Resort {name:'Италия 1'})-[:IN]->(ci5), (r6:Resort {name:'Болгария 1'})-[:IN]->(ci6), (r7:Resort {name:'Испания 1'})-[:IN]->(ci7), (r8:Resort {name:'Швеция 1'})-[:IN]->(ci8), (r9:Resort {name:'Германия 1'})-[:IN]->(ci9), (r10:Resort {name:'Польша 1'})-[:IN]->(ci10), (r11:Resort {name:'Турция 2'})-[:IN]->(ci1), (r12:Resort {name:'Египет 2'})-[:IN]->(ci2), (r13:Resort {name:'Тунис 2'})-[:IN]->(ci3), (r14:Resort {name:'Франция 2'})-[:IN]->(ci4), (r15:Resort {name:'Италия 2'})-[:IN]->(ci5)
MERGE (o1)-[:RESORT]-(r1)
MERGE (o1)-[:RESORT]-(r2)
MERGE (o1)-[:RESORT]-(r3)
MERGE (o1)-[:RESORT]-(r4)
MERGE (o1)-[:RESORT]-(r5)
MERGE (o1)-[:RESORT]-(r6)
MERGE (o1)-[:RESORT]-(r7)
MERGE (o1)-[:RESORT]-(r8)
MERGE (o1)-[:RESORT]-(r9)
MERGE (o1)-[:RESORT]-(r10)
MERGE (o2)-[:RESORT]-(r1)
MERGE (o2)-[:RESORT]-(r2)
MERGE (o2)-[:RESORT]-(r3)
MERGE (o2)-[:RESORT]-(r4)
MERGE (o2)-[:RESORT]-(r5)
MERGE (o2)-[:RESORT]-(r6)
MERGE (o2)-[:RESORT]-(r7)
MERGE (o2)-[:RESORT]-(r8)
MERGE (o2)-[:RESORT]-(r9)
MERGE (o3)-[:RESORT]-(r2)
MERGE (o3)-[:RESORT]-(r3)
MERGE (o3)-[:RESORT]-(r4)
MERGE (o3)-[:RESORT]-(r5)
MERGE (o3)-[:RESORT]-(r6)
MERGE (o3)-[:RESORT]-(r7)
MERGE (o3)-[:RESORT]-(r8)
MERGE (o3)-[:RESORT]-(r9)
MERGE (o4)-[:RESORT]-(r3)
MERGE (o4)-[:RESORT]-(r4)
MERGE (o4)-[:RESORT]-(r5)
MERGE (o4)-[:RESORT]-(r6)
MERGE (o4)-[:RESORT]-(r7)
MERGE (o5)-[:RESORT]-(r1)
MERGE (o5)-[:RESORT]-(r2)
MERGE (o5)-[:RESORT]-(r3)
MERGE (o5)-[:RESORT]-(r4)
MERGE (o5)-[:RESORT]-(r5)
MERGE (o5)-[:RESORT]-(r6)
MERGE (o5)-[:RESORT]-(r7)
MERGE (ci1)-[:WAY {type: 'airplane'}]-(ci2)
MERGE (ci2)-[:WAY {type: 'airplane'}]-(ci3)
MERGE (ci3)-[:WAY {type: 'airplane'}]-(ci4)
MERGE (ci4)-[:WAY {type: 'ship'}]-(ci5)
MERGE (ci4)-[:WAY {type: 'ship'}]-(ci7)
MERGE (ci4)-[:WAY {type: 'ship'}]-(ci7)
MERGE (ci5)-[:WAY {type: 'train'}]-(ci6)
MERGE (ci7)-[:WAY {type: 'airplane'}]-(ci8)
MERGE (ci8)-[:WAY {type: 'airplane'}]-(ci9)
MERGE (ci9)-[:WAY {type: 'airplane'}]-(ci10)
MERGE (ci10)-[:WAY {type: 'airplane'}]-(ci1)
MERGE (ci1)-[:WAY {type: 'bus'}]->(ci2)
MERGE (ci2)-[:WAY {type: 'bus'}]->(ci3)
MERGE (ci5)-[:WAY {type: 'bus'}]->(ci6)
MERGE (ci6)-[:WAY {type: 'bus'}]->(ci7)
MERGE (ci9)-[:WAY {type: 'train'}]->(ci10)
MERGE (ci10)-[:WAY {type: 'train'}]->(ci1)
MERGE (ci1)<-[:WAY {type: 'bus'}]-(ci2)
MERGE (ci2)<-[:WAY {type: 'bus'}]-(ci3)
MERGE (ci3)<-[:WAY {type: 'airplane'}]-(ci4)
MERGE (ci4)<-[:WAY {type: 'bus'}]-(ci5)
MERGE (ci5)<-[:WAY {type: 'bus'}]-(ci6)
````

## Прямой путь самолетом

````cypher
MATCH (ci1:City)-[w:WAY{type:'airplane'}]->(ci2:City)
RETURN *
````

## Путь наземным транспортом, в том числе с пересадками

````cypher
MATCH (ci1:City)-[w:WAY*]->(ci2:City)
WHERE ALL(wi IN w WHERE wi.type IN ['train', 'bus', 'ship'])
RETURN *
````

## Очистка

````cypher
MATCH (a) -[r] -> () DELETE a, r
````

````cypher
MATCH (a) DELETE a
````

