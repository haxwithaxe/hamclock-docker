ARG BASE_IMAGE=alpine:3.21
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="haxwithaxe W3AXE"
LABEL org.opencontainers.image.description="HamClock by WBØOEW in a Docker container"
LABEL org.opencontainers.image.source="https://github.com/haxwithaxe/hamclock-docker"

ENV HOME=/hamlib

WORKDIR /

# Install prerequisites
RUN apk update && apk add --no-cache curl make g++ unzip openssl perl

# Install HamClock
RUN curl -O https://www.clearskyinstitute.com/ham/HamClock/ESPHamClock.zip && \
    unzip ESPHamClock.zip && \
    mv ESPHamClock /hamclock && \
    chmod 777 /hamclock && \
    mkdir /hamclock/.hamclock && \
    cd /hamclock && \
    sed -i 's/-O3/-O2/g' Makefile && \
    make -j 4 hamclock-web-800x480 && \
    mv hamclock-web-* /usr/bin/ && \
    make clean && \
    make -j 4 hamclock-web-1600x960 && \
    mv hamclock-web-* /usr/bin/ && \
    make clean && \
    make -j 4 hamclock-web-2400x1440 && \
    mv hamclock-web-* /usr/bin/ && \
    make clean && \
    make -j 4 hamclock-web-3200x1920 && \
    mv hamclock-web-* /usr/bin/ && \
    make clean && \
    mv hamclock-web-* /usr/bin/ && \
    chmod -R a+rwX /hamclock

# Cleanup
WORKDIR /hamclock
RUN apk del --no-cache make unzip

# Install entry point
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+rx /entrypoint.sh

VOLUME /hamclock/.hamclock

HEALTHCHECK --interval=30s --timeout=10s --start-period=2m --retries=3 CMD curl -f http://localhost:8080/get_sys.txt || exit 1
CMD /entrypoint.sh
