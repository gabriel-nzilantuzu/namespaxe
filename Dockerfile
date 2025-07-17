FROM nginx:alpine

# Create the directory nginx needs and set permissions
RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R 1000:1000 /var/cache/nginx

USER 1000  # use non-root user with UID 1000

COPY . /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
