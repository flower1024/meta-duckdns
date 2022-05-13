#!/bin/sh

source /env

IP4=$(curl "http://fritz.box:49000/igdupnp/control/WANIPConn1" -H "Content-Type: text/xml; charset="utf-8"" -H "SoapAction:urn:schemas-upnp-org:service:WANIPConnection:1#GetExternalIPAddress" -d "<?xml version='1.0' encoding='utf-8'?> <s:Envelope s:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'> <s:Body> <u:GetExternalIPAddress xmlns:u='urn:schemas-upnp-org:service:WANIPConnection:1' /> </s:Body> </s:Envelope>" -s | grep -Eo '\<[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}\>')
IP6=$(curl "http://fritz.box:49000/igdupnp/control/WANIPConn1" -H "Content-Type: text/xml; charset="utf-8"" -H "SoapAction:urn:schemas-upnp-org:service:WANIPConnection:1#X_AVM_DE_GetExternalIPv6Address" -d "<?xml version='1.0' encoding='utf-8'?> <s:Envelope s:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'> <s:Body> <u:GetExternalIPAddress xmlns:u='urn:schemas-upnp-org:service:WANIPConnection:1' /> </s:Body> </s:Envelope>" -s | grep  -Eo '<NewExternalIPv6Address>.*</NewExternalIPv6Address>' | cut -c 25- | rev | cut -c 26- | rev)

if [ "$IP6" = "" ]
then
    echo -n "Connecting: https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=$IP4 "
    curl "https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=$IP4" > /dev/null 2>&1 && echo OK || echo FAILED
else
    echo -n "Connecting: https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=$IP4&ipv6=$IP6 "
    curl "https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=$IP4&ipv6=$IP6" > /dev/null 2>&1 && echo OK || echo FAILED
fi
