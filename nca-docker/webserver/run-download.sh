#!/bin/bash

docker run \
  --name api \
  --network host \
  --mount source=data,destination=/var/lib/jetty/webapps/ROOT/download \
  -e NCA_MODEL_RASTER="/opt/nkmodel/raster/nederland" \
  -e NCA_MODEL_RUNNER="/nkmodel" \
  -e NCA_MODEL_TKS_RUNNER="/nkmodel" \
  -e NCA_TKS_MEASURES="tks_measures.json" \
  -e NCA_DOWNLOAD_PATH="/var/lib/jetty/webapps/ROOT/download" \
  -e NCA_DOWNLOAD_URL="http://api.gbpapi.nl/download" \
  -v /tmp:/tmp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  nca-gbp-webserver:latest


