export pentaho_host=${PENTAHO_HOST:-${HOSTNAME}}
export pentaho_url=${PENTAHO_URL:-https://${pentaho_host}/pentaho}
export pgsql_host=${PGSQL_HOST:-postgresql}
export pgsql_port=${PGSQL_PORT:-5432}
export pgsql_user=${PGSQL_USER:-pgadmin}
export pgsql_password=${PGSQL_PASSWORD:-pgadmin.}
export pgsql_database=${PGSQL_DATABASE:-postgres}
export hib_user_password=${HIB_USER_PASSWORD:-$(openssl rand -hex 16)}
export jcr_user_password=${JCR_USER_PASSWORD:-$(openssl rand -hex 16)}
export pentaho_user_password=${PENTAHO_USER_PASSWORD:-$(openssl rand -hex 16)}

find \
  ${PENTAHO_HOME}/pentaho-server/data \
  ${PENTAHO_HOME}/pentaho-server/tomcat/webapps \
  ${PENTAHO_HOME}/pentaho-server/tomcat/conf \
  ${PENTAHO_HOME}/pentaho-server/pentaho-solutions/system \
  -name "*.xml" -o -name "*.properties" -o -name "*.sql" | while read filename
do
  sed -i -r \
    -e "s/@@pentaho_host@@/${pentaho_host}/g" \
    -e "s@\@\@pentaho_url\@\@@${pentaho_url}@g" \
    -e "s/@@db_host@@/${pgsql_host}/g" \
    -e "s/@@db_port@@/${pgsql_port}/g" \
    -e "s/@@hib_user_password@@/${hib_user_password}/g" \
    -e "s/@@jcr_user_password@@/${jcr_user_password}/g" \
    -e "s/@@pentaho_user_password@@/${pentaho_user_password}/g" \
    -e "s/login-show-sample-users-hint>true/login-show-sample-users-hint>false/g" \
    "${filename}"
done
