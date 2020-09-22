#!/bin/bash

#https://github.com/nginx-proxy/docker-letsencrypt-nginx-proxy-companion

docker run --detach \
    --name nginx-proxy \
    --publish 80:80 \
    --publish 443:443 \
    --volume /etc/nginx/certs \
    --volume /etc/nginx/vhost.d \
    --volume /usr/share/nginx/html \
    --volume /var/run/docker.sock:/tmp/docker.sock:ro \
    jwilder/nginx-proxy


docker run --detach \
    --name nginx-proxy-letsencrypt \
    --volumes-from nginx-proxy \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --env "DEFAULT_EMAIL=john.verberne@gmail.com" \
    jrcs/letsencrypt-nginx-proxy-companion


docker run --detach \
  --name api-proxy \
  --env "VIRTUAL_HOST=tks.captainjohn.nl" \
  --env "LETSENCRYPT_HOST=tks.captainjohn.nl" \
  gbp-proxy:latest



