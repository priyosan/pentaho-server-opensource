#!/bin/bash


HOSTNAME=$(hostname)

sed -i "s/server1/server-${HOSTNAME}/g" slave_dyn.xml

if [ "$CARTE_USER" -a "$CARTE_PASS" ]
then
  echo "${CARTE_USER}: $(./encr.sh -carte $CARTE_PASS | tail -1)" > pwd/kettle.pwd
fi

if [ -f "./custom_script.sh" ]
then
  . ./custom_script.sh
  mv ./custom_script.sh ./custom_script.sh.$(date +%s)
fi

./carte.sh slave_dyn.xml
