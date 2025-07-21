FROM nginx:alpine

# Create required directories with proper permissions
RUN mkdir -p /var/cache/nginx/client_temp /tmp && \
    chown -R 1000:1000 /var/cache/nginx /tmp

USER 1000

COPY . /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
