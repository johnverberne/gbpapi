FROM jetty:jre8-alpine

# The following ENV variables are set by default. Overwrite them to suit your configuration.
ENV APPNAME app

# Convenience variables
ENV JETTY_WEBAPPS "${JETTY_BASE}/webapps"
ENV JETTY_LIB_EXT "${JETTY_BASE}/lib/ext"
ENV CONTEXT_TEMPLATE "/context.xml"

# Copy the needed extra dependencies to use pooling
COPY jetty-deps/*.jar "${JETTY_LIB_EXT}"/

# Copy context.xml template containing the database configuration
COPY context.xml "${CONTEXT_TEMPLATE}"

# Copy realm.properties containing the user password configuration
COPY realm.properties "${JETTY_WEBAPPS}"/etc/

# Run commands as root - otherwise we cannot move the already present file
USER root

# Move default entrypoint and replace it with our own.
# This will replace the placeholders in the configuration file for the application before starting Jetty.
RUN mv /docker-entrypoint.sh /docker-jetty-entrypoint.sh
COPY docker-entrypoint.sh /

# Copy the webapp
COPY /gbp-app/* "${JETTY_WEBAPPS}"/app/

# Install envsubst - while this adds a dependency it's cleans up the rest of the shell script/configuration files,
#  making sure we don't have to use sed and other weird constructs to update configuration files. It's worth it.
RUN apk --no-cache add libintl gettext

# Back to proper user
USER jetty

# Expose port that Jetty is running on
EXPOSE 4200



