#!/bin/bash

alias date="date +%d-%h-%Y-%H-%m-%S"

echo $(date) "Starting Configuration Decryption Check" >> /var/log/configdecrypt.log

if ! [[ -z "${RESINPOT}" ]]; then
  # Grab BASE64 variables from ENV 
  echo $(date) "" >> /var/log/configdecrypt.log
  CONFIG_PATH=`echo $RESINPOT | cut -d . -f 1 | base64 -d`
  CONFIG_SERVICE=`echo $RESINPOT | cut -d . -f 2 | base64 -d`
  # CONFIG_MD5=`echo $RESINPOT | cut -d . -f 3 | base64 -d`
  CONFIG_DATA=`echo $RESINPOT | cut -d . -f 4 | base64 -d`

  echo $(date) "Replacing current configuration" >> /var/log/configdecrypt.log
  echo $CONFIG_DATA > $CONFIG_PATH

  if [ "$RESINPOT_SCRIPT_DEBUG" = "true" ]; then
    echo $CONFIG_DATA >> /var/log/configdecrypt.log
  fi

  systemctl restart $CONFIG_SERVICE
  echo $(date) "Boot Config Decrypt Completed" >> /var/log/configdecrypt.log
else
  echo $(date) "$(RESINPOT) variable unset, leaving default configuration" >> /var/log/configdecrypt.log
fi

echo $(date) "Ending Configuration Decryption Check" >> /var/log/configdecrypt.log

