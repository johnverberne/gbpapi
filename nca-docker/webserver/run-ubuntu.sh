#!/bin/bash

docker run \
  -it \
  --name ex1 \
  --network host \
  --mount source=datadownload,destination=/datadownload\
  ubuntu:latest


