#!/bin/bash
# Script to run pcraster with NatuurlijkKapitaalModellen and related data.
# The scripts starts a docker file and runs a specific model, after executing the docker instance is removed.
# Basically it runs pcraster in a container, so it's not necessary to locally install pcraster.

# location of the NKM python model code. The following line is for when they are in the directory this script is located.
#export NKM_HOME=`dirname $(readlink -f $0)`/home/johnverberne/nkmodel/NatuurlijkKapitaalModellen
export NKM_HOME=/home/johnverberne/nkmodel/NatuurlijkKapitaalModellen
# location of the nkmodel data
export NCM_WORKSPACE=/home/johnverberne/nkmodel
echo 0:$0 1:$1 2:$2 3:$3 4:$4 5:$5 6:$6
echo gdal-python

echo Log the version from git
git -C $NKM_HOME status
git -C $NKM_HOME log -1

ls -a -l $NKM_HOME
ls -a -l $NCM_WORKSPACE

echo log python version in docker container
docker run --rm nca-docker python --version

echo docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/air_regulation.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/air_regulation.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/air_regulation.py $3

echo docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_water_and_residential_amenity.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_water_and_residential_amenity.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_water_and_residential_amenity.py $3

echo docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_and_health.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_and_health.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/green_space_and_health.py $3

# new models added 21-9-2020

echo docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/physical_activity.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/physical_activity.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/physical_activity.py $3

echo docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/wood_production_vegetation.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/wood_production_vegetation.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/wood_production_vegetation.py $3

echo docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/carbon_sequestration_vegetation.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/carbon_sequestration_vegetation.py $2
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/carbon_sequestration_vegetation.py $3

echo deterime diff
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/ncm_diff.py $5 $4 $6
echo add raster descriptions
docker run --rm -v /tmp:/tmp nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/ncm_rasterdescriptions.py $6 /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/mapdescriptions.ini
