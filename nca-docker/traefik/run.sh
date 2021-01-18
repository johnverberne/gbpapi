#!/bin/bash

#https://github.com/containous/traefik-library-image

docker run -d -p 9090:9090 -p 80:80 \
-v $PWD/traefik.toml:/etc/traefik/traefik.toml \
-v /var/run/docker.sock:/var/run/docker.sock \
traefik:v1.7
