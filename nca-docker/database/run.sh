docker run -d \
  --name dev-postgres \
  --restart always \
  --mount source=postgres-data,destination=/var/lib/postgresql/data \
  -p 5433:5432 \
  -e POSTGRES_PASSWORD="postgres" \
  postgres




