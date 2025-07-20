FROM louislam/uptime-kuma:latest

USER root
RUN chown -R 1000:1000 /app/data

USER 1000
