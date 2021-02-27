#!/bin/sh

INTERFACE=$1
INTERFACE_NUMBER=`echo $INTERFACE | cut -c 3-`
PID=`cat /var/ppp-v6/$INTERFACE_NUMBER.pid`

if [ "$PROTO" == "inet6" ]
then
	kill $PID
	rm /var/ppp-v6/$INTERFACE_NUMBER.*
fi
