#!/bin/bash

docker run \
  --name api \
  --network web \
  -e NCA_MODEL_RASTER="/opt/nkmodel/raster/nederland" \
  -e NCA_MODEL_RUNNER="/nkmodel" \
  -e NCA_MODEL_TKS_RUNNER="/nkmodel" \
  -e NCA_TKS_MEASURES="tks_measures.json" \
  -v /tmp:/tmp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -l traefik.backend=gbpapi \
  -l traefik.frontend.rule=Host:acc.gbpapi.nl \
  -l traefik.port=8080 \
  -l traefik.docker.network=web \
  nca-gbp-webserver:latest


#docker run --rm \
#  -l traefik.docker.network=host \
#-v /opt/nkmodel:/opt/nkmodel \
#-v /opt/nkmodeltks:/opt/nkmodeltks \
#-v /opt/nkmodel/raster/nederland:/opt/nkmodel/raster/nederland \

