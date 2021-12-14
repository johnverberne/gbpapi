#!/bin/bash

docker run -de \
  --name dev-pgadmin \
  --restart always \
  -p 80:80 \
  -e PGADMIN_DEFAULT_EMAIL="johnverberne@gmail.com" \
  -e PGADMIN_DEFAULT_PASSWORD="postgres" \
  dpage/pgadmin4
