FROM ubuntu:focal-20211006 AS add-apt-repositories

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg wget\
 && cd /root \
 && wget https://download.webmin.com/jcameron-key.asc \
 && apt-key add jcameron-key.asc \
 && echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list

FROM ubuntu:focal-20211006

LABEL maintainer="developer@slab42.net"

ENV BIND_USER=bind \
    BIND_VERSION=9.16.21-1+ubuntu20.04.1+isc+1 \
    WEBMIN_VERSION=1.981 \
    DATA_DIR=/data

COPY --from=add-apt-repositories /etc/apt/trusted.gpg /etc/apt/trusted.gpg

COPY --from=add-apt-repositories /etc/apt/sources.list /etc/apt/sources.list

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
 && add-apt-repository ppa:isc/bind \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      bind9=1:${BIND_VERSION}* bind9-host=1:${BIND_VERSION}* dnsutils \
      webmin=${WEBMIN_VERSION}* \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp 10000/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/named"]
