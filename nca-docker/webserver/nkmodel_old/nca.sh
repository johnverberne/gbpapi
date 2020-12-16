#!/bin/bash
# Script to run pcraster with NatuurlijkKapitaalModellen and related data.
# The scripts starts a docker file and runs a specific model, after executing the docker instance is removed.
# Basically it runs pcraster in a container, so it's not necessary to locally install pcraster.

# location of the NKM python model code. The following line is for when they are in the directory this script is located.
export NKM_HOME=`dirname $(readlink -f $0)`/NatuurlijkKapitaalModellen
# location of the nkmodel data
export NCM_WORKSPACE=/opt/nkmodel
docker run --rm -v /tmp:/tmp -v $NKM_HOME:/opt/nkmodel/NatuurlijkKapitaalModellen -v $NCM_WORKSPACE:/opt/nkmodel -e NCM_CONFIGURATION='/opt/nkmodel/NatuurlijkKapitaalModellen/environment/configuration/ncm.ini' nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/$1.py $2
