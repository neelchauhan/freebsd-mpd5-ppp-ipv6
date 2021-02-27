#!/bin/sh

INTERFACE=$1
INTERFACE_NUMBER=`echo $INTERFACE | cut -c 3-`
PROTO=$2

if [ "$PROTO" == "inet6" ]
then
	SUBNET=666:0:0:$INTERFACE_NUMBER
	ifconfig $INTERFACE inet6 $SUBNET::1 prefixlen 64
	echo "$INTERFACE:\\" >> /var/ppp-v6/$INTERFACE_NUMBER.conf
	echo "	:addr=\"666:0:0:$INTERFACE_NUMBER::\":prefixlen#64:" >> /var/ppp-v6/$INTERFACE_NUMBER.conf
	rtadvd -D -c /var/ppp-v6/$INTERFACE_NUMBER.conf -p /var/ppp-v6/$INTERFACE_NUMBER.pid $INTERFACE
fi
