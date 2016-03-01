FROM java

# Create dirs
RUN mkdir /opt/liquibase
RUN mkdir /opt/jdbc_drivers

# Download liquibase
RUN curl http://repo1.maven.org/maven2/org/liquibase/liquibase-core/3.3.0/liquibase-core-3.3.0-bin.tar.gz \
  | tar -xzC /opt/liquibase

# Make liquibase executable
RUN chmod +x /opt/liquibase/liquibase

# Symlink to liquibase to be on the path
RUN ln -s /opt/liquibase/liquibase /usr/local/bin/

# Add postgres driver
RUN curl http://central.maven.org/maven2/org/postgresql/postgresql/9.3-1102-jdbc41/postgresql-9.3-1102-jdbc41.jar > /opt/jdbc_drivers/postgresql-9.3-1102-jdbc41.jar

# Add script
RUN mkdir /scripts
COPY update.sh /scripts/
RUN chmod -R +x /scripts/update.sh

VOLUME ["/changelogs"]

WORKDIR /

ENTRYPOINT ["/scripts/update.sh"]
