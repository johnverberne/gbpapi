#!/bin/bash

#https://github.com/containous/traefik-library-image

#docker network ls
#docker network create web

#https://tks.captainjohn.nl/api/doc

docker run -d -p 9090:9090 -p 80:80 -p 443:443 \
-v $PWD/traefik.toml:/etc/traefik/traefik.toml \
-v $PWD/acme.json:/acme.json \
-v /var/run/docker.sock:/var/run/docker.sock \
-l traefik.frontend.rule=Host:tks.captainjohn.nl,connect.gbpapi.nl \
-l traefik.port=8080 \
--network host \
--name traefik-proxy \
traefik:v1.7

