FROM alpine

# Define packages for compiling Ruby gems
ENV COMPILE_PACKAGES "gcc libc-dev make patch zlib-dev \
                      imagemagick6-dev postgresql-dev ruby-dev"

ENV REDMINE_VERSION "redmine-4.0.9"

# Add user for Redmine
RUN adduser -D -H redmine

# Install Ruby
RUN apk --no-cache add ${COMPILE_PACKAGES} su-exec postgresql-client tzdata ruby \
                       ruby-bundler ruby-bigdecimal ruby-json

# Install and configure Redmine
RUN wget https://www.redmine.org/releases/${REDMINE_VERSION}.tar.gz -P /opt && \
    tar -C /opt -xvf /opt/${REDMINE_VERSION}.tar.gz && \
    cd /opt/${REDMINE_VERSION} && \
    mkdir -p tmp/pdf public/plugin_assets && \
    chown -R redmine:redmine files log tmp public/plugin_assets && \
    chmod -R 755 files log tmp public/plugin_assets && \
    # fill up "database.yml" with bogus entry so the Redmine Gemfile will pre-install postgresql database adapter
    echo -e \
    "production:\n\
       adapter: postgresql" > config/database.yml && \
    sed -i s/2.7.0/2.8.0/ /opt/${REDMINE_VERSION}/Gemfile && \
    bundle install --without development && \
    # remove fake configuration file
    rm config/database.yml

# Delete packages for compiling
RUN apk del ${COMPILE_PACKAGES}

EXPOSE "3000"

COPY docker-entrypoint.sh /usr/local/sbin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["puma", "-e", "production", "-p", "3000"]
