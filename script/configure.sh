export pentaho_host=${PENTAHO_HOST:-${HOSTNAME}}
export pentaho_url=${PENTAHO_URL:-https://${pentaho_host}/pentaho}
export mysql_host=${MYSQL_HOST:-mysql}
export mysql_port=${MYSQL_PORT:-3306}
export mysql_user=${MYSQL_USER:-root}
export mysql_password=${MYSQL_PASSWORD:-super}
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
    -e "s/@@db_host@@/${mysql_host}/g" \
    -e "s/@@db_port@@/${mysql_port}/g" \
    -e "s/@@hib_user_password@@/${hib_user_password}/g" \
    -e "s/@@jcr_user_password@@/${jcr_user_password}/g" \
    -e "s/@@pentaho_user_password@@/${pentaho_user_password}/g" \
    -e "s/login-show-sample-users-hint>true/login-show-sample-users-hint>false/g" \
    "${filename}"
done
