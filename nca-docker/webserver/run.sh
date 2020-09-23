#!/bin/bash

docker run --rm \
  --name api \
  --network host \
  -e NCA_MODEL_RASTER="/opt/nkmodel/raster/nederland" \
  -e NCA_MODEL_RUNNER="/nkmodel" \
  -e NCA_MODEL_TKS_RUNNER="/nkmodel" \
  -e NCA_TKS_MEASURES="tks_measures.json" \
  -v /tmp:/tmp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  nca-gbp-webserver:latest



#-v /opt/nkmodel:/opt/nkmodel \
#-v /opt/nkmodeltks:/opt/nkmodeltks \
#-v /opt/nkmodel/raster/nederland:/opt/nkmodel/raster/nederland \

