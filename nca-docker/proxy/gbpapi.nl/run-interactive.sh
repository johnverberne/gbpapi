#!/bin/bash

#https://github.com/nginx-proxy/docker-letsencrypt-nginx-proxy-companion

docker run --rm \
    --name nginx-proxy \
    --publish 80:80 \
    --publish 443:443 \
    --volume /etc/nginx/certs \
    --volume /etc/nginx/vhost.d \
    --volume /usr/share/nginx/html \
    --volume /var/run/docker.sock:/tmp/docker.sock:ro \
    jwilder/nginx-proxy


docker run --rm \
    --name nginx-proxy-letsencrypt \
    --volumes-from nginx-proxy \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --env "DEFAULT_EMAIL=john.verberne@gmail.com" \
    jrcs/letsencrypt-nginx-proxy-companion


docker run --rm \
  --name api-gbp-proxy \
  --env "VIRTUAL_HOST=connect.gbpapi.nl" \
  --env "LETSENCRYPT_HOST=connect.gbpapi.nl" \
  gbp-proxy:latest

