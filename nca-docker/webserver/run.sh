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
  -e NCA_MODEL="/opt/nkmodel/raster/nederland" \
  nca-gbp-webserver:latest
