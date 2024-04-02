#!/bin/bash
set -e

cat /tmp/postgresql.conf.1.sample > /opt/bitnami/postgresql/conf/postgresql.conf
cat /tmp/pg_hba.1.conf.sample > /opt/bitnami/postgresql/conf/pg_hba.conf

# warning: danger
export PGPASSWORD=adminpassword
psql -U postgres -c 'ALTER USER codebaseuser REPLICATION;'