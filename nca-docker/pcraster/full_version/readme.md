This is the Dockerfile to build a docker container containing pcraster and the NatuurlijkKapitaalModellen python code.

This project contains a script `nca.sh` that is used by nca-service to call pc-raster.

To build the Docker file the following needs to be done:
- Place the pcraster binary in the folder of the Docker file. The version is code in the Dockerfile. Current version is : `pcraster-4.1.0_x86-64.tar.gz`.
- Clone the NatuurlijkKapitaalModellen in this folder. It will be included in the Dockerfile

The `nca.sh` script passes the NatuurlijkKapitaalModellen folder as virtual folder. This makes it possible to modify the script code without having to rebuild the Docker container.


How to build the docker container, we use the docker description file Dockerfile

docker build -t nca-docker .
docker images
docker run -it --rm nca-docker /bin/bash
