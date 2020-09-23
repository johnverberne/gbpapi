#!/bin/sh

ls
echo -----testing some scripts on access and working-------
ls /opt/nkmodel
echo -----------
ls /opt/nkmodel/NatuurlijkKapitaalModellen
echo -----------
ls /opt/nkmodel/raster/nederland
echo -----------
whoami
#echo -----------------
#sh /opt/nkmodel/ncaogr2ogr.sh
#echo ------------------------
#ls /nkmodel
echo ------------------------
sh /nkmodel/ncaogr2ogr.sh
echo ------------------------
ls /tmp
echo -----------------------
set -e
echo -----end testing on working--------------------------

# Destination path for the context.xml
CONTEXT_DESTINATION="${JETTY_WEBAPPS}/${APPNAME}.xml"

# replace placeholders in configuration and write it to proper place
envsubst < "${CONTEXT_TEMPLATE}" > "${CONTEXT_DESTINATION}"

# execute jetty's default entrypoint to start Jetty by default
/docker-jetty-entrypoint.sh "${@}"
