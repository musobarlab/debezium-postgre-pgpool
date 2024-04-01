#!/bin/bash
set -e

cat /tmp/postgresql.conf.1.sample > /bitnami/postgresql/conf/postgresql.conf
cat /tmp/pg_hba.1.conf.sample > /bitnami/postgresql/confpg_hba.conf