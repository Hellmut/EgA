#!/bin/sh

GLOBAL_IP_FILE=$1

while [ 1 ]; do
    IP1=$(cat $GLOBAL_IP_FILE)
    IP2=""

    while [ -z "$IP2" ]; do
        IP2="$(curl -s ifconfig.co)";
        sleep 60;
    done;

     if [ "$IP1" != "$IP2" ]; then
      echo -e "Subject: IP alert: \n\n raspberry new ip: $IP2 " | ssmtp michalpiotrszymanski@gmail.com;
     fi
    echo "$IP2" >$GLOBAL_IP_FILE
    sleep 60; 
 
    #if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
done
#EOF
