### GBP API Web application image

The webapp war should be placed in this directory as `api.war` while building the image.

##### Example build
```shell
docker build -t nca-gbp-webserver:latest .
```

##### Example run
```shell
docker run --rm --network host \
  -e DBPASSWORD="password" \
  -p 8080:8080 \
  nca-gbp-webserver:latest
```

##### Example run with custom DBNAME
```shell
docker run --rm --network host \
  -e DBPASSWORD="password" \
  -e DBNAME="unittest_calculator" \
  -p 8080:8080 \
  nca-gbp-webserver:latest
```
