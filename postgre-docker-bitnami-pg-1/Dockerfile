FROM docker.io/bitnami/postgresql-repmgr:12

# Copy the script which will initialize the replication permissions
COPY init-custom-config.sh /docker-entrypoint-initdb.d/_init-custom-config.sh
COPY postgresql.conf /tmp/postgresql.conf.1.sample
COPY pg_hba.conf /tmp/pg_hba.1.conf.sample