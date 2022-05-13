#!/bin/sh

if [ -f /var/log/script.log ]
then
    rm /var/log/script.log
fi

echo TOKEN=$TOKEN > /env
echo DOMAINS=$DOMAINS >> /env

/script.sh

/usr/sbin/crond -f -l 8