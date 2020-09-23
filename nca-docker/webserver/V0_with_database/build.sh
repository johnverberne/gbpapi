#!/bin/bash
#build latest version
#../../nca-service/mvn clean install -Papi -DskipTests
#copy latest version
cp ../../nca-service/nca-webserver/target/nca-webserver.war api.war
#build docker file
docker build -t nca-gbp-webserver:latest .
