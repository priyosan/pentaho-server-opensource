#!/bin/bash

if [ "${PGSQL_HOST}" != "" ]
then
  ${PENTAHO_HOME}/script/setup_postgresql.sh
else
  ${PENTAHO_HOME}/script/setup_mysql.sh
fi
