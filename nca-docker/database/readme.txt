backup database

docker exec -t dev-postgres pg_dumpall -c -U postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
dump_14-07-2021_16_44_20.sql

cat your_dump.sql | docker exec -i your-db-container psql -U postgres


### tips
docker ps
docker stop <name>
docker rm <name>

Add
--restart always 


readme for portgres
 container

### postgres

docker pull postgres
docker volume create postgres-data

docker run -d \
	--name dev-postgres\
        --restart always \
      	-e POSTGRES_PASSWORD=postgres \
	-v postgres-data:/var/lib/postgresql/data \
        -p 5433:5432 \
        postgres


docker ps
docker exec -it dev-postgres bash
psql -h localhost -U postgres
\l


### pgadmin
docker pull dpage/pgadmin4

docker run -d \
  --name dev-pgadmin \
  --restart always \
  --network host \
  -p 80:80 \
  -e PGADMIN_DEFAULT_EMAIL="johnverberne@gamil.com" \
  -e PGADMIN_DEFAULT_PASSWORD="postgres" \
  dpage/pgadmin4

find ip adress
docker inspect dev-postgres -f "{{json .NetworkSettings.Networks }}"

### sql tests

ALTER TABLE measures
ADD id Text;

UPDATE measures
SET id = '0000-0000-0000-0000',
WHERE condition;

insert into measures (id,name,api_key,measures,validated,active)
values ('0002','test 2','0000-0000-0000-0001','{"measures":[
   {
      "id":3,
      "code":"STREETTREES",
      "runmodel":true,
      "description":"Straatbomen en bomenlanen",
      "layers":[{"layer":"TREES","value":0.25}]
   }]}', true, false);


