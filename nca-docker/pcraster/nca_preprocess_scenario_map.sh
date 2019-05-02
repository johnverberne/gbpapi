#!/bin/bash
# The scripts starts a docker file and runs a specific task with col2map and pcrcalc, after executing the docker instance is removed.
echo ----------------------
echo start col2map -S  $1 $2 --clone $3
echo ----------------------
docker run --rm -v /tmp:/tmp nca-docker col2map -S  $1 $2 --clone $3
echo ----------------------
echo start pcrcalc $5=cover\($4, $5\) 
echo ----------------------
echo test run to copy as new file
docker run --rm -v /tmp:/tmp nca-docker pcrcalc $6=cover\($4, $5\) 
echo keep this version
docker run --rm -v /tmp:/tmp nca-docker pcrcalc $5=cover\($4, $5\) 
echo ----------------------


