FROM alpine

# Install PostgreSQL
RUN apk --no-cache add su-exec musl-locales musl-locales-lang postgresql

# Create necessary directory for PostgreSQL
RUN mkdir /run/postgresql && chown postgres:postgres /run/postgresql && \
    chmod 700 /run/postgresql

EXPOSE "5432"

# Prepare database
COPY docker-entrypoint.sh /usr/local/sbin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["postgres", "-D", "/var/lib/postgresql/data"]
