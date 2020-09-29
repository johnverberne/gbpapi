#!/bin/bash

#https://github.com/nginx-proxy/docker-letsencrypt-nginx-proxy-companion


docker run --rm \
  --name api-gbp-proxy \
  --env "VIRTUAL_HOST=connect.gbpapi.nl" \
  --env "LETSENCRYPT_HOST=connect.gbpapi.nl" \
  gbp-proxy:latest

