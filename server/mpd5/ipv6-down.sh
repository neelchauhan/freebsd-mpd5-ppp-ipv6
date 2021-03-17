#!/bin/sh

INTERFACE=$1
PID=`cat /var/ppp-v6/$INTERFACE.pid`

if [ "$PROTO" == "inet6" ]
then
	kill $PID
	rm /var/ppp-v6/$INTERFACE.*
fi
