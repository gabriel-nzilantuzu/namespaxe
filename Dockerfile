FROM louislam/uptime-kuma:latest

USER root

RUN mkdir -p /app/data

USER 1000