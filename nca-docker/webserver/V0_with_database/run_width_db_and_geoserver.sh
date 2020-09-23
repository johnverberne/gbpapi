#!/bin/bash
docker run --rm \
  --name api \
  --network host \
  -e DBPASSWORD="hallo2dirk337" \
  -e DBHOSTNAME="localhost:5432" \
  -e DBNAME="unittest_NCA-gbp" \
  -e GEOSERVER_PASSWORD="hallo2dirk337" \
  -e GEOSERVER_URL="http://131.224.198.104:8080/geoserver-gbp" \
  -e GEOSERVER_USER="root" \
  -e NCA_MODEL_RASTER="/opt/nkmodel/raster/nederland" \
  -e NCA_MODEL_RUNNER="/opt/nkmodel" \
  -e NCA_MODEL_RUNNER_TKS_RUNNER="/opt/nkmodeltks" \
  -e NCA_TKS_MEASURES = "tks_measures.json"\
  nca-gbp-webserver:latest
