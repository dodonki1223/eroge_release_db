FROM openjdk:8u212-jdk-alpine

ENV LC_ALL=C

ARG SCHEMASPY_VERSION
ARG MYSQL_VERSION
ARG MARIADB_VERSION
ARG POSTGRESQL_VERSION
ARG JTDS_VERSION

ADD .dockerdev/schemaspy/open-sans.tar.gz /usr/share/fonts/

RUN adduser java -h / -D && \
    set -x && \
    apk add --no-cache curl unzip graphviz fontconfig && \
    fc-cache -fv && \
    mkdir -p /drivers_inc /jar_file /output /usr/local/lib/schemaspy && \
    curl -JLo /drivers_inc/mysql-connector-java-$MYSQL_VERSION.jar http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/$MYSQL_VERSION/mysql-connector-java-$MYSQL_VERSION.jar && \
    curl -JLo /drivers_inc/mariadb-java-client-$MARIADB_VERSION.jar http://search.maven.org/remotecontent?filepath=org/mariadb/jdbc/mariadb-java-client/$MARIADB_VERSION/mariadb-java-client-$MARIADB_VERSION.jar && \
    curl -JLo /drivers_inc/postgresql-$POSTGRESQL_VERSION.jre7.jar http://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/$POSTGRESQL_VERSION.jre7/postgresql-$POSTGRESQL_VERSION.jre7.jar && \
    curl -JLo /drivers_inc/jtds-$JTDS_VERSION.jar http://search.maven.org/remotecontent?filepath=net/sourceforge/jtds/jtds/$JTDS_VERSION/jtds-$JTDS_VERSION.jar && \
    curl -JLo /jar_file/schemaspy-$SCHEMASPY_VERSION.jar https://github.com/schemaspy/schemaspy/releases/download/v$SCHEMASPY_VERSION/schemaspy-$SCHEMASPY_VERSION.jar && \
    cp /jar_file/schemaspy-$SCHEMASPY_VERSION.jar /usr/local/lib/schemaspy/schemaspy.jar && \
    chown -R java /drivers_inc && \
    chown -R java /output && \
    apk del curl

COPY .dockerdev/schemaspy/schemaspy.sh /usr/local/bin/schemaspy

USER java
WORKDIR /

ENV SCHEMASPY_DRIVERS=/drivers
ENV SCHEMASPY_OUTPUT=/output

ENTRYPOINT ["/usr/local/bin/schemaspy"]
