#!/usr/bin/env sh

cd /opt/${REDMINE_VERSION}

# Configure database connection
echo -e \
"production:\n\
   adapter: postgresql\n\
   database: ${DB_NAME}\n\
   host: ${DB_HOST}\n\
   username: ${DB_USER}\n\
   password: "${DB_PASSWORD}"\n\
   encoding: utf8" > config/database.yml

# Prepare database for Redmine
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production REDMINE_LANG=en bundle exec rake redmine:load_default_data

exec su-exec redmine "$@"
