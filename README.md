## PostgreSQL Server Configuration

### Define PostgreSQL role that has at least the `REPLICATION` and `LOGIN` permissions.

For example we create role with the name `DEBEZIUM_LISTEN`, and assign the user we created to that role

```sql
CREATE USER <debezium_user_you_created>;

CREATE ROLE DEBEZIUM_LISTEN REPLICATION LOGIN;

GRANT DEBEZIUM_LISTEN TO <debezium_user_you_created>;
```

### Replication Configuration.

`postgresql.conf`
```
# REPLICATION
wal_level = logical

# for increasing the number of connectors that can access the sending server concurrently
max_wal_senders = 1 
max_replication_slots = 1 
```

### Add entries to the pg_hba.conf file to specify the Debezium connector hosts that can replicate with the database host.

`pg_hba.conf`
```
# Allow replication connections from localhost, by a user with the replication privilege.
local   replication     <debezium_user_you_created>                                     trust
host    replication     <debezium_user_you_created>             127.0.0.1/32            trust
host    replication     <debezium_user_you_created>             ::1/128                 trust

```

### Start services & and simultaneously execute all the configuration requirements above. Open `postgre-docker` folder for details
```shell
$ docker-compose up
```

## Kafka Connect Rest API
https://docs.confluent.io/platform/current/connect/references/restapi.html#kconnect-rest-interface

### Start JDBC Sink Connector (Postgre Target Table MOVIE)
```shell
$ curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://127.0.0.1:8083/connectors/ -d @jdbc-sink-table-movie.json
```

### Start JDBC Sink Connector (Postgre Target Table PERSON)
```shell
$ curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://127.0.0.1:8083/connectors/ -d @jdbc-sink-table-person.json
```

### Start Debezium PostgreSQL CDC connector (PostgreSQL Source)

```shell
$ curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://127.0.0.1:8083/connectors/ -d @postgre-source.json
```

### Insert or update example data to PostgreSQL
```
debeziumtest=# INSERT INTO MOVIE(TITLE, DESCRIPTION) VALUES('Spiderman 2', 'good');

debeziumtest=# INSERT INTO MOVIE(TITLE, DESCRIPTION) VALUES('Spiderman 3', 'good');
```

### Now, the data in the Postgres database should also change
```shell
debeziumtest=# SELECT * FROM "public"."dbpostgresqlserver1_publicmovie;";
 DESCRIPTION |      created_at      |                   TITLE                    | ID 
-------------+----------------------+--------------------------------------------+----
 good        | 2023-03-06T14:11:18Z | Spiderman 2                                | 1
 good        | 2023-03-06T15:32:54Z | Spiderman 3                                | 2
(2 rows)
```

#### Kafka CLI

List `topic`
```shell
$ /bin/kafka-topics.sh --zookeeper zookeeper:2181 --list
```

Subscribe to `topic`
```shell
$ /bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic-name --from-beginning
```

#### Reference
- https://debezium.io/documentation/reference/stable/connectors/postgresql.html#setting-up-postgresql