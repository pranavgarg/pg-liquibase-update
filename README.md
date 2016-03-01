postgres-liquibase-update
================

Docker image to execute a liquibase update

The image uses liquibase 3.3.0 and postgres driver 9.3-1102-jdbc41

When run the container will execute a liquibase update of a specified changelog on a linked postgres container

#### Example use

```
docker run -id \
  --link=thePostgresContainer:postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=database \
  -e POSTGRES_HOST=postgres \
  -e POSTGRES_PORT=5432 \
  -e CHANGELOG_FILE=changelog.xml \
  -v /project/liquibase:/changelogs \
  --name liquibase \
  beresfordt/pg-liquibase-update
```

The environment variables required are:

POSTGRES_USER - the user to the target database  
POSTGRES_PASSWORD - password to the target database  
POSTGRES_DB - the target database name  
POSTGRES_HOST - the IP address of the target database  
POSTGRES_PORT - the port postgres is running on
CHANGELOG_FILE - the name of the changelog file

The volume must mount the directory within which the changelog resides