#!/bin/bash

CONFIG_PATH=`echo $RESINPOT | cut -d . -f 1 | base64 -d`
CONFIG_MD5=`echo $RESINPOT | cut -d . -f 2 | base64 -d`
CONFIG_DATA=`echo $RESINPOT | cut -d . -f 3 | base64 -d`

echo $CONFIG_DATA > $CONFIG_PATH
# md5sum $CONFIG_MD5 $CONFIG_PATH

echo "Config Decrypt Completed" > /var/log/configdecrypt.log