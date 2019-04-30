FROM aerius-database-build:9.4

ENV DBDATA_PATH db-data/gbp
ENV DBCONFIG_PATH aerius-database-build/config

ENV GIT_HOSTNAME github.com
ENV GIT_ORG rivm-syso
ENV GIT_REPOSITORY GroeneBatenPlanner

ARG SFTP_READONLY_PASSWORD
ARG GIT_USERNAME
ARG GIT_TOKEN

ENV DBSOURCE_PATH nca-databaswe-gbp
ENV DATABASE_NAME NCA-gbp

RUN /build-database.sh
