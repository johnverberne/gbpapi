#!/bin/bash
# run ogr2ogr in docker 
echo docker run --rm -v /tmp:/tmp nca-docker ogr2ogr $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15}
docker run --rm -v /tmp:/tmp nca-docker ogr2ogr $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15}
#ogr2ogr $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15}
