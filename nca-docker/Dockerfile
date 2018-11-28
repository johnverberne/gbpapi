FROM python:2.7

ARG pcraster=pcraster-4.1.0_x86-64

COPY ${pcraster}.tar.gz /tmp/${pcraster}.tar.gz

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-numpy lsb libjpeg62 && \
    cd /opt && \
    tar zxf /tmp/${pcraster}.tar.gz && \
    rm /tmp/${pcraster}.tar.gz

ENV PATH=/opt/${pcraster}/bin:$PATH
ENV PYTHONPATH=/opt/${pcraster}/python:$PYTHONPATH

### Install python modules for NatuurlijkKapitaalModellen ###

COPY NatuurlijkKapitaalModellen/environment/configuration/requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt

### Install NatuurlijkKapitaalModellen ###
COPY NatuurlijkKapitaalModellen/ /opt/NatuurlijkKapitaalModellen/

ENV PYTHONPATH=/opt/NatuurlijkKapitaalModellen/source/script/:$PYTHONPATH

ENV NCM_WORKSPACE=/opt/nkmodel
ENV NCM_CONFIGURATION=/opt/NatuurlijkKapitaalModellen/environment/configuration/ncm.ini

