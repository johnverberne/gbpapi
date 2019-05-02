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

docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/$1.py $2
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/$1.py $3
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/ncm_diff.py $4 $5 $6
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/ncm_rasterdescriptions.py $6 /opt/nkmodel/NatuurlijkKapitaalModellen/environment/script/mapdescriptions.ini


