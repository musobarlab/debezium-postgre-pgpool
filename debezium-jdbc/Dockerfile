ARG DEBEZIUM_VERSION
FROM quay.io/debezium/connect:${DEBEZIUM_VERSION}
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc

ARG POSTGRES_VERSION=42.3.5
ARG MYSQL_VERSION=1.9.7.Final
ARG KAFKA_JDBC_VERSION=5.3.1

# Deploy PostgreSQL JDBC Driver
RUN cd /kafka/libs && curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar &&\
	curl -sO https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/$MYSQL_VERSION/debezium-connector-mysql-$MYSQL_VERSION-plugin.tar.gz &&\
	tar -xvzf debezium-connector-mysql-$MYSQL_VERSION-plugin.tar.gz

# Deploy Kafka Connect JDBC plugin
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar