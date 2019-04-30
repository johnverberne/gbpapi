#!/bin/bash
docker run --rm \
  --name app \
  --network host \
  -e GEOSERVER_URL="http://131.224.198.104:8080/geoserver-gbp" \
  nca-gbp-appserver:latest
