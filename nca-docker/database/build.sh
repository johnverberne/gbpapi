#!/bin/bash
docker build \
  --build-arg GIT_USERNAME="johnverberne" \
  --build-arg GIT_TOKEN="e912280d25a718ec17314050cf62c838cff834d7" \
  --build-arg SFTP_READONLY_PASSWORD="MaFFJROWUY" \
  -t nca-database-gbp:latest .
