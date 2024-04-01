FROM docker.io/bitnami/pgpool:4

COPY init-debezium.sql /docker-entrypoint-initdb.d/
COPY postgre.create_table_sample.sql /docker-entrypoint-initdb.d/