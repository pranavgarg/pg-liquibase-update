#!/bin/bash -e

echo "Setting up liquidbase"
: ${POSTGRES_USER?"POSTGRES_USER not set"}
: ${POSTGRES_PASSWORD?"POSTGRES_PASSWORD not set"}

cat <<CONF > /liquibase.properties
  driver: org.postgresql.Driver
  classpath:/opt/jdbc_drivers/postgresql-9.3-1102-jdbc41.jar
  url: jdbc:postgresql://$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB
  username: $POSTGRES_USER
  password: $POSTGRES_PASSWORD
CONF

echo "Applying changelogs ..."
: ${CHANGELOG_FILE:="changelogs.xml"}

liquibase --changeLogFile="/changelogs/$CHANGELOG_FILE" update
