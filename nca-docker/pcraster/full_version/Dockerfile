FROM python:3.6

ARG pcraster=pcraster-4.2.1_x86_64

COPY ${pcraster}.tar.gz /tmp/${pcraster}.tar.gz

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y python3-numpy lsb libjpeg62 gdal-bin python3-gdal \
    && cd /opt \
    && tar zxf /tmp/${pcraster}.tar.gz \
    && rm /tmp/${pcraster}.tar.gz \
    # Configure pcraster lib directory to be used globally
    && echo "/opt/${pcraster}/lib" > /etc/ld.so.conf.d/pcraster.conf \
    # Update config to detect new library files
    && ldconfig

ENV PATH=/opt/${pcraster}/bin:$PATH
ENV PYTHONPATH=/opt/${pcraster}/python:$PYTHONPATH

### Install python modules for NatuurlijkKapitaalModellen ###

COPY NatuurlijkKapitaalModellen/environment/configuration/requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt

### Install NatuurlijkKapitaalModellen ###
COPY NatuurlijkKapitaalModellen/ /opt/nkmodel/NatuurlijkKapitaalModellen/

### Install input for NatuurlijkKapitaalModellen
COPY input/ /opt/nkmodel/input/

ENV PYTHONPATH=/opt/NatuurlijkKapitaalModellen/source/script/:$PYTHONPATH

ENV NCM_WORKSPACE=/opt/nkmodel
ENV NCM_CONFIGURATION=/opt/NatuurlijkKapitaalModellen/environment/configuration/ncm.ini

