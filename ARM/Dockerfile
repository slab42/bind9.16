FROM arm64v8/debian:buster-backports

LABEL maintainer="aaron@slab42.net"

ENV BIND_USER=bind \
    WEBMIN_VERSION=1.941 \
    BIND_VERSION=1:9.16.8-1~bpo10+1 \
    DATA_DIR=/data


RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y wget bind9=${BIND_VERSION} perl libnet-ssleay-perl openssl \
      libauthen-pam-perl libpam-runtime libio-pty-perl dnsutils unzip shared-mime-info\
      apt-show-versions python \
 && wget "http://prdownloads.sourceforge.net/webadmin/webmin_${WEBMIN_VERSION}_all.deb" -P /tmp/ \
 && dpkg -i /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 10000/tcp
VOLUME ["${DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/sbin/named"]
