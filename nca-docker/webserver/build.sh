#!/bin/bash
#build latest version
cd ../../nca-service
mvn clean install -Papi -DskipTests -Dmaven.test.skip=true -fae 
cd ../nca-docker/webserver
#copy latest version
cp ../../nca-service/nca-webserver/target/nca-webserver.war api.war
#build docker file
docker build -t nca-gbp-webserver:latest .
