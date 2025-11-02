FROM alpine:3.22.2

LABEL org.opencontainers.image.authors="Tim Beermann <tibeer@berryit.de>" \
      org.opencontainers.image.description="" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="containered-pxe" \
      org.opencontainers.image.url="http://github.com/berryit/containered-pxe" \
      org.opencontainers.image.source="http://github.com/berryit/containered-pxe" \
      org.opencontainers.image.vendor="berryit.de"

RUN apk add --no-cache \
    bash=5.2.37-r0 \
    busybox=1.37.0-r19 \
    curl=8.14.1-r2 \
    dnsmasq=2.91-r0 \
    gettext-envsubst=0.24.1-r0 \
    nginx=1.28.0-r3 \
    shadow=4.17.3-r0 \
    sudo=1.9.17_p2-r0 \
    supervisor=4.2.5-r5 \
    syslog-ng=4.8.3-r1 \
    tar=1.35-r3 \
    && rm -rf /var/cache/apk/*

ENV TFTPD_OPTS='' \
    NGINX_PORT='4480' \
    PUID='1000' \
    PGID='1000'

EXPOSE 69/udp
EXPOSE 80

COPY --chown=root:root container_root/ /

RUN chmod +x /start.sh /init.sh /healthcheck.sh /usr/local/bin/dnsmasq-wrapper.sh

HEALTHCHECK --interval=30s --timeout=15s --start-period=60s --retries=3 \
    CMD /healthcheck.sh

CMD ["/start.sh"]
