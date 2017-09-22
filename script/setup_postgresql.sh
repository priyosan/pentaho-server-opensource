#!/bin/bash
set -e
export PGPASSWORD="$pgsql_password"

wait_for_db() {
  local host="${1}"
  local port="${2}"

  num_wait=0
  max_wait=30
  until [ $(nc -zv ${host} ${port} 2>/dev/null >/dev/null; echo $?) -eq 0 ]
  do
    num_wait=$((num_wait+1))
    if [ $num_wait -gt $max_wait ]
    then
      echo "Database server port never initialized"
      exit 1
    fi

    sleep 1
  done
}

initialize_quartz() {
  local db_connect_string="psql -U $pgsql_user  -h $pgsql_host -d $pgsql_database"
  local database_list="$(${db_connect_string} -l)"
  local chk_quartz="$(echo "${database_list}" | grep quartz | wc -l)"
  echo "quartz: ${chk_quartz}"

  if [ ${chk_quartz} -eq 0 ]
  then
    ${db_connect_string} -f $PENTAHO_HOME/pentaho-server/data/postgresql/create_quartz_postgresql.sql > /dev/null
  fi
}

initialize_hibernate() {
  local db_connect_string="psql -U $pgsql_user  -h $pgsql_host -d $pgsql_database"
  local database_list="$(${db_connect_string} -l)"
  local chk_hibernate="$(echo "${database_list}" | grep hibernate | wc -l)"
  echo "hibernate: ${chk_hibernate}"

  if [ ${chk_hibernate} -eq 0 ]
  then
    ${db_connect_string} -f $PENTAHO_HOME/pentaho-server/data/postgresql/create_repository_postgresql.sql > /dev/null
  fi
}

initialize_jcr() {
  local db_connect_string="psql -U $pgsql_user  -h $pgsql_host -d $pgsql_database"
  local database_list="$(${db_connect_string} -l)"
  local chk_jcr="$(echo "${database_list}" | grep jackrabbit | wc -l)"
  echo "jcr: ${chk_jcr}"

  if [ ${chk_jcr} -eq 0 ]
  then
    ${db_connect_string} -f $PENTAHO_HOME/pentaho-server/data/postgresql/create_jcr_postgresql.sql > /dev/null
  fi
}

initialize_sdata() {
  local db_connect_string="psql -U $pgsql_user  -h $pgsql_host -d $pgsql_database"
  local database_list="$(${db_connect_string} -l)"
  local chk_sdata="$(echo "${database_list}" | grep sampledata | wc -l)"
  echo "sampledata: ${chk_sdata}"

  if [ ${chk_sdata} -eq 0 ]
  then
    ${db_connect_string} -f $PENTAHO_HOME/pentaho-server/data/postgresql/sampledata.sql > /dev/null
  fi
}

echo "Checking PostgreSQL connection ..."
wait_for_db $pgsql_host $pgsql_port

if [ "$USE_RDS" == "true" ]
then
  sed -i 's/TABLESPACE = pg_default;/;/g' $PENTAHO_HOME/pentaho-server/data/postgresql/*.sql
fi

initialize_quartz
initialize_hibernate
initialize_jcr
initialize_sdata
