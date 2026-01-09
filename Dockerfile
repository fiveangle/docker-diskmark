# Use an official base image
FROM alpine:latest AS deps
RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash fio linux-firmware-none lsblk

FROM deps
COPY diskmark.sh /usr/local/bin/diskmark
VOLUME /disk
WORKDIR /disk
ENV TARGET="/disk"
ENV PROFILE="auto"
ENV IO="direct"
ENV DATA="random"
ENV SIZE="1G"
ENV WARMUP="1"
ENV RUNTIME="5s"
ENTRYPOINT [ "diskmark" ]
