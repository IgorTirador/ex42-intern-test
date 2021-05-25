#!/usr/bin/env sh

# Initialize database
export LANG="en_US.UTF-8"
su-exec postgres /usr/bin/initdb --pgdata /var/lib/postgresql/data

# Configure PostgreSQL for remote connections
sed -i s/#listen_addresses\ =\ \'localhost\'/listen_addresses\ =\ \'*\'/ /var/lib/postgresql/data/postgresql.conf
echo "host all all all md5" >> /var/lib/postgresql/data/pg_hba.conf

# Create user and database
su-exec postgres pg_ctl start -D /var/lib/postgresql/data
psql -U postgres -c "CREATE ROLE ${PG_USER} LOGIN ENCRYPTED PASSWORD '${PG_PASSWORD}' NOINHERIT VALID UNTIL 'infinity';"
psql -U postgres -c "CREATE DATABASE ${PG_DB} WITH ENCODING='UTF8' OWNER=${PG_USER};"
su-exec postgres pg_ctl stop -D /var/lib/postgresql/data -m fast

exec su-exec postgres "$@"
