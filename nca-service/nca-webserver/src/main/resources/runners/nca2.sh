#!/bin/bash
# Script to run pcraster with NatuurlijkKapitaalModellen and related data.
# The scripts starts a docker file and runs a specific model, after executing the docker instance is removed.
# Basically it runs pcraster in a container, so it's not necessary to locally install pcraster.

# location of the NKM python model code. The following line is for when they are in the directory this script is located.
export NKM_HOME=`dirname $(readlink -f $0)`/NatuurlijkKapitaalModellen
# location of the nkmodel data
export NCM_WORKSPACE=/opt/nkmodel
echo 0:$0 1:$1 2:$2 3:$3 4:$4 5:$5 6:$6
echo gdal-python

echo Log the version from git
git -C $NKM_HOME status
git -C $NKM_HOME log -1

echo log python version in docker container
docker run --rm nca-docker python --version

echo run model air_regulation on scenario data $2
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/air_regulation.py $2
echo run model air_regulation on baseline data $3
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/air_regulation.py $3

echo run model cooling_in_urban_areas on scenario $2
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/cooling_in_urban_areas.py $2
echo run model cooling_in_urban_areas on baseline $3
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/cooling_in_urban_areas.py $3

echo run model green_space_and_health scenario $2
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_and_health.py $2
echo run model green_space_and_health baseline $3
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_and_health.py $3

echo determine the difference between baseline and scenario results $4 $5 $6
#python -c "print 'determine the difference between baseline and scenario results'"
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/ncm_diff.py $4 $5 $6

echo create json result from diff results maps $6
#python -c "print 'create json from diff results maps'"
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/ncm_rasterdescriptions.py $6 /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/mapdescriptions.ini

