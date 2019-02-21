nca-api + nca-webserver -> generate sources & java build paths
Evt. #version weghalen

Synchroniseer FTP bron: verberne ftp GroeneBatenPlanner-data/, doel: c:\projects\gbp\gbp-data\
DB bouwen: mvn clean install -Pbuild -DskipTests

 http://localhost:8080/geoserver-gbp/gbp2/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gbp2:wms_grids_view&maxFeatures=50&outputFormat=application%2Fjson
 
 Tiff via geoserver: Add bron -> geotiff aanwijzen
 http://localhost:8080/geoserver-gbp/gbp/wms?service=WMS&version=1.1.0&request=GetMap&layers=gbp:bomen&styles=&bbox=140805.71307963246,458578.75272987,142171.9592291604,459496.5518461125&width=768&height=515&srs=EPSG:28992&format=application/openlayers#toggle