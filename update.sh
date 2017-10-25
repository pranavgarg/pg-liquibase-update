#!/bin/sh

echo "Setting up liquidbase"
: ${POSTGRES_USER?"POSTGRES_USER not set"}
: ${POSTGRES_PASSWORD?"POSTGRES_PASSWORD not set"}

cat <<CONF > /home/duser/liquibase.properties
  driver: org.postgresql.Driver
  classpath:/opt/jdbc_drivers/postgresql-9.4.1212.jre7.jar
  url: jdbc:postgresql://$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB
  username: $POSTGRES_USER
  password: $POSTGRES_PASSWORD
CONF

echo "Applying changelogs ..."
: ${CHANGELOG_FILE:="changelogs.xml"}

ERROR_EXIT_CODE=1
MAX_TRIES=${MAX_TRIES:-4}
COUNT=1
while [  $COUNT -le $MAX_TRIES ]; do
   echo  "Attempting to apply changelogs: attempt $COUNT of $MAX_TRIES"
   liquibase --changeLogFile="/changelogs/$CHANGELOG_FILE" update
   if [ $? -eq 0 ];then
   	  echo "Changelogs successfully applied"
      exit 0
   fi
   echo "Failed to apply changelogs"
   sleep 1
   let COUNT=COUNT+1
done
echo "Too many non-successful tries"
exit $ERROR_EXIT_CODE
