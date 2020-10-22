#!/bin/bash
# The scripts starts a docker file and runs a specific task pcrcalc, after executing the docker instance is removed.

#export new file to show it worked.
echo docker run --rm -v /tmp:/tmp nca-docker pcrcalc $3=cover\($2, $1\) 
docker run --rm -v /tmp:/tmp nca-docker pcrcalc $3=cover\($2, $1\) 

#overwrite input for the model
echo docker run --rm -v /tmp:/tmp nca-docker pcrcalc $2=cover\($2, $1\) 
docker run --rm -v /tmp:/tmp nca-docker pcrcalc $2=cover\($2, $1\) 


