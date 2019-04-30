#!/bin/sh

set -e

# Destination path for the context.xml
CONTEXT_DESTINATION="${JETTY_WEBAPPS}/${APPNAME}.xml"

# replace placeholders in configuration and write it to proper place
envsubst < "${CONTEXT_TEMPLATE}" > "${CONTEXT_DESTINATION}"

# execute jetty's default entrypoint to start Jetty by default
/docker-jetty-entrypoint.sh "${@}"
