FROM jetty:jre8-alpine

# The following ENV variables are set by default. Overwrite them to suit your configuration.
ENV APPNAME api
#ENV DATASOURCENAME AeriusDB
#ENV DBNAME "unittest_NCA-gbp"
#ENV DBHOSTNAME localhost
#ENV DBUSERNAME aerius
#ENV DBPASSWORD hallo2dirk337

# Convenience variables
ENV JETTY_WEBAPPS "${JETTY_BASE}/webapps"
ENV JETTY_LIB_EXT "${JETTY_BASE}/lib/ext"
ENV CONTEXT_TEMPLATE "/context.xml"

# Copy the needed extra dependencies to use pooling
COPY jetty-deps/*.jar "${JETTY_LIB_EXT}"/

# Copy context.xml template containing the database configuration
COPY context.xml "${CONTEXT_TEMPLATE}"

# Create download dir in jetty
run mkdir "${JETTY_WEBAPPS}"/ROOT
run mkdir "${JETTY_WEBAPPS}"/ROOT/download
COPY empty.txt "${JETTY_WEBAPPS}"/ROOT/download

# Run commands as root - otherwise we cannot move the already present file
USER root

# Move default entrypoint and replace it with our own.
# This will replace the placeholders in the configuration file for the application before starting Jetty.
RUN mv /docker-entrypoint.sh /docker-jetty-entrypoint.sh
COPY docker-entrypoint.sh /

# Copy the webapp-java
COPY api.war "${JETTY_WEBAPPS}"/

# Copy shell script files to run
COPY ./nkmodel/. /nkmodel

# Add docker group using the group ID as found on the host
RUN addgroup -g 997 docker \
    \
    # Add jetty to docker group
    && addgroup jetty docker \
    # Install envsubst - while this adds a dependency it's cleans up the rest of the shell script/configuration files,
    #  making sure we don't have to use sed and other weird constructs to update configuration files. It's worth it.
    # It also installs Docker
    && apk --no-cache add libintl gettext bash docker

# Back to proper user
USER jetty

# Expose port that Jetty is running on
EXPOSE 8080

# Overwrite defaults by our specific configuration.
ENV APPNAME api
ENV DBNAME unittest_NCA-gbp

