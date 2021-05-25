FROM alpine

# Define packages for compiling Ruby gems
ENV COMPILE_PACKAGES "gcc libc-dev make patch zlib-dev \
                      imagemagick6-dev postgresql-dev ruby-dev"

ENV REDMINE_VERSION "redmine-4.0.9"
ENV PG_DB "redmine"
ENV PG_USER "redmine"
ENV PG_PASSWORD "9zgYOSd8wi*6(2R,=/Uv"

# Add user for Redmine
RUN adduser -D -H redmine

# Install PostgreSQL, Ruby and nginx
RUN apk --no-cache add ${COMPILE_PACKAGES} musl-locales musl-locales-lang \
                       postgresql ruby ruby-bundler ruby-bigdecimal ruby-json nginx

# Create necessary directories for PostgreSQL and nginx
RUN mkdir /run/postgresql && chown postgres:postgres /run/postgresql && chmod 700 /run/postgresql && \
    mkdir /run/nginx && chown nginx:nginx /run/nginx && chmod 700 /run/nginx

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Install and configure Redmine
RUN wget https://www.redmine.org/releases/${REDMINE_VERSION}.tar.gz -P /opt && \
    tar -C /opt -xvf /opt/${REDMINE_VERSION}.tar.gz && \
    cd /opt/${REDMINE_VERSION} && \
    mkdir -p tmp/pdf public/plugin_assets && \
    chown -R redmine:redmine files log tmp public/plugin_assets && \
    chmod -R 755 files log tmp public/plugin_assets && \
    echo -e \
    "production:\n\
      adapter: postgresql\n\
      database: ${PG_DB}\n\
      host: localhost\n\
      username: ${PG_USER}\n\
      password: "${PG_PASSWORD}"\n\
      encoding: utf8" > config/database.yml && \
    sed -i s/2.7.0/2.8.0/ /opt/${REDMINE_VERSION}/Gemfile && \
    bundle install --without development

# Delete packages for compiling
RUN apk del ${COMPILE_PACKAGES}

EXPOSE "80"

# Configure nginx
COPY default.conf /etc/nginx/conf.d/

# Prepare database for Redmine and start Puma application server
COPY docker-entrypoint.sh /usr/local/sbin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
