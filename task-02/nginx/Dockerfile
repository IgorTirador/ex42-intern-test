FROM alpine

# Install nginx
RUN apk --no-cache add nginx

# Create necessary directory for nginx
RUN mkdir /run/nginx && chown nginx:nginx /run/nginx && chmod 700 /run/nginx

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Configure nginx
COPY default.conf /etc/nginx/conf.d/

EXPOSE "80"

CMD ["nginx", "-g", "daemon off;"]
