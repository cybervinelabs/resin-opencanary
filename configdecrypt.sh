#!/bin/bash

CONFIG_PATH=`echo $RESINPOT | cut -d . -f 1 | base64 -d`
CONFIG_SERVICE=`echo $RESINPOT | cut -d . -f 2 | base64 -d`
# CONFIG_MD5=`echo $RESINPOT | cut -d . -f 3 | base64 -d`
CONFIG_DATA=`echo $RESINPOT | cut -d . -f 4 | base64 -d`

CMP1=`echo -n $CONFIG_DATA | md5sum | cut -d" " -f1`
CMP2=`cat $CONFIG_PATH | md5sum | cut -d" " -f1`

if ! [ "$CMP1" = "$CMP2" ]; then
  echo $CONFIG_DATA > $CONFIG_PATH
  if [ $RESINPOT_SCRIPT_DEBUG = "true" ]; then
    cat $CONFIG_PATH > /var/log/configdecrypt.log
  fi
  systemctl restart $CONFIG_SERVICE
  echo $(date +%F) "Config Decrypt Completed" > /var/log/configdecrypt.log
fi

