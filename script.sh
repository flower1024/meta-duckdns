#!/bin/sh

source /env

IP4=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
IP6=$(curl v6.ident.me 2> /dev/null)
echo -n "Connecting: https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=$IP4&ipv6=$IP6 "
curl "https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=$IP4&ipv6=$IP6" > /dev/null 2>&1 && echo OK || echo FAILED