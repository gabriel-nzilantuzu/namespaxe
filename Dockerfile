FROM nginx:alpine

# Create required directory with correct permissions
RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R 1000:1000 /var/cache/nginx

# Set non-root user
USER 1000

# Copy site and custom config
COPY . /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]