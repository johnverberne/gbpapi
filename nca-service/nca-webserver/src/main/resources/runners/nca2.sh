#!/bin/bash
# Script to run pcraster with NatuurlijkKapitaalModellen and related data.
# The scripts starts a docker file and runs a specific model, after executing the docker instance is removed.
# Basically it runs pcraster in a container, so it's not necessary to locally install pcraster.

# location of the NKM python model code. The following line is for when they are in the directory this script is located.
export NKM_HOME=`dirname $(readlink -f $0)`/NatuurlijkKapitaalModellen
# location of the nkmodel data
export NCM_WORKSPACE=/opt/nkmodel
echo $0 $1 $2 $3 $4 $5 $6
echo gdal-python

#printf "Log the version from git"
#git --git-dir=$NKM_HOME status

printf "model air_regulation"
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/air_regulation.py $2
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/air_regulation.py $3

printf "model cooling_in_urban_areas"
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/cooling_in_urban_areas.py $2
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/cooling_in_urban_areas.py $3

#printf "model green_space_and_health"
echo model green_space_and_health
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_and_health.py $2
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_and_health.py $3

#printf "determine the difference between baseline and scenario results"
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/ncm_diff.py $4 $5 $6

#printf "create json from diff results maps"
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/ncm_rasterdescriptions.py $6 /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/mapdescriptions.ini


