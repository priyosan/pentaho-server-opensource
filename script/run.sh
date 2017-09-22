#!/bin/bash
set -e

. $PENTAHO_HOME/script/configure.sh

if [ ! -f ".pentaho_dbconfig" ]; then
  $PENTAHO_HOME/script/setup_postgresql.sh
  touch .pentaho_dbconfig
fi

if [ ! -f ".install_plugin" ]; then
  $PENTAHO_HOME/script/install_plugin.sh
  touch .install_plugin
fi

if [ -f "./custom_script.sh" ]; then
  . ./custom_script.sh
  mv ./custom_script.sh ./custom_script.sh.$(date +%s)
fi

$PENTAHO_HOME/pentaho-server/start-pentaho.sh
