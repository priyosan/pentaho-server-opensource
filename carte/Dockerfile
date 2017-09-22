FROM java:8

MAINTAINER Wellington Marinho wpmarinho@globo.com

# Init ENV
ENV PENTAHO_VERSION 7.1
ENV PENTAHO_TAG 7.1.0.0-12
ENV PENTAHO_HOME /opt/pentaho

# Apply JAVA_HOME
RUN . /etc/environment
ENV PENTAHO_JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64

RUN apt-get update \
  && apt-get install wget unzip postgresql-client-9.4 mysql-client libwebkitgtk-1.0 -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir ${PENTAHO_HOME} && useradd -s /bin/bash -d ${PENTAHO_HOME} pentaho && chown pentaho:pentaho ${PENTAHO_HOME}

# Download Pentaho BI Server
RUN /usr/bin/wget http://downloads.sourceforge.net/project/pentaho/Data%20Integration/${PENTAHO_VERSION}/pdi-ce-${PENTAHO_TAG}.zip -O /tmp/pdi-ce-${PENTAHO_TAG}.zip \
 && /usr/bin/unzip -q /tmp/pdi-ce-${PENTAHO_TAG}.zip -d  $PENTAHO_HOME \
 && rm /tmp/pdi-ce-${PENTAHO_TAG}.zip

COPY script/ $PENTAHO_HOME/data-integration/
COPY slave_dyn.xml $PENTAHO_HOME/data-integration/

RUN chown -R pentaho:pentaho $PENTAHO_HOME

USER pentaho
WORKDIR $PENTAHO_HOME/data-integration
EXPOSE 8181
CMD ["./run.sh"]
