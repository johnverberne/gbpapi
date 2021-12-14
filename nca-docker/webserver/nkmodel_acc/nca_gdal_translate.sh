#!/bin/bash
# run gdal translate in docker 
# echo docker run --rm -v /tmp:/tmp -v /opt/nkmodel/raster/nederland:/opt/nkmodel/raster/nederland nca-docker gdal_translate $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15}
# docker run --rm -v /tmp:/tmp -v /opt/nkmodel/raster/nederland:/opt/nkmodel/raster/nederland nca-docker gdal_translate $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15}

# raster files in docker container
echo docker run --rm -v /tmp:/tmp -v /opt/nkmodel/raster/nederland:/opt/nkmodel/raster/nederland nca-docker gdal_translate $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15}
docker run --rm -v /tmp:/tmp -v -v /opt/nkmodel/raster/nederland:/opt/nkmodel/raster/nederland nca-docker gdal_translate $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15}

