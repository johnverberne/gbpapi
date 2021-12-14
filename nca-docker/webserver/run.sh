#!/bin/bash

docker run \
  --name api \
  --network host \
  -e NCA_MODEL_RASTER="/opt/nkmodel/raster/nederland" \
  -e NCA_MODEL_RUNNER="/nkmodel" \
  -e NCA_MODEL_TKS_RUNNER="/nkmodel" \
  -e NCA_TKS_MEASURES="tks_measures.json" \
  -e NCA_DOWNLOAD_PATH="/tmp/download" \
  -e NCA_DOWNLOAD_URL="http://api.gbpapi.nl/download" \
  -v /tmp:/tmp \
  -v /tmp/download:/tmp/download \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp/download:/var/lib/jetty/webapps/ROOT/download \
  nca-gbp-webserver:latest


