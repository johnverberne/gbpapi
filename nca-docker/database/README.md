### DB image

##### Example build
```shell
docker build \
  --build-arg GIT_USERNAME="username" \
  --build-arg GIT_TOKEN="token" \
  --build-arg SFTP_READONLY_PASSWORD="password" \
  -t aerius-database-calculator:latest .

docker build \
  --build-arg GIT_USERNAME="username" \
  --build-arg GIT_TOKEN="token" \
  --build-arg SFTP_READONLY_PASSWORD="password" \
  --t nca-database:latest .
```

##### Example run
```shell
docker run --rm --network host aerius-database-calculator:latest
```

