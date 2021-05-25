#!/usr/bin/env sh

# Initialize database
export LANG="en_US.UTF-8"
su postgres -c "/usr/bin/initdb --pgdata /var/lib/postgresql/data"

# Prepare database for Redmine
su postgres -c "pg_ctl start -D /var/lib/postgresql/data"
psql -U postgres -c "CREATE ROLE ${PG_USER} LOGIN ENCRYPTED PASSWORD '${PG_PASSWORD}' NOINHERIT VALID UNTIL 'infinity';"
psql -U postgres -c "CREATE DATABASE ${PG_DB} WITH ENCODING='UTF8' OWNER=${PG_USER};"
cd /opt/${REDMINE_VERSION}
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production REDMINE_LANG=en bundle exec rake redmine:load_default_data

# Start Redmine in Puma application server
puma -e production -p 3000 -d

exec "$@"
