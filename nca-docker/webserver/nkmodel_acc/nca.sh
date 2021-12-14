#!/bin/bash
# Script to run pcraster with NatuurlijkKapitaalModellen and related data.
# The scripts starts a docker file and runs a specific model, after executing the docker instance is removed.
# Basically it runs pcraster in a container, so it's not necessary to locally install pcraster.
docker run --rm -v /tmp:/tmp -e NCM_CONFIGURATION='/opt/nkmodel/NatuurlijkKapitaalModellen/environment/configuration/ncm.ini' nca-docker python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/$1.py $2
