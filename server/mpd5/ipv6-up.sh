#!/bin/sh

# User configurable options
# Note: PREFIX_LEN has to be a multiple of 4
PREFIX="666:420:69"
PREFIX_LEN=48

# Beyond here is (normally) not user-configurable for non-shell hackers

PREFIX=`printf '$PREFIX' | sed 's/:://'`

if [ $(( $PREFIX_LEN % 16 )) == 0 ]
then
	PREFIX=`printf '$PREFIX:'`
fi

INTERFACE=$1
INTERFACE_INT=`echo $INTERFACE | cut -c 3-`
INTERFACE_ID=`printf '%x' $INTERFACE_INT`
PROTO=$2

if [ "$PROTO" == "inet6" ]
then
	SUBNET=$PREFIX$INTERFACE_ID
	ifconfig $INTERFACE inet6 $SUBNET::1 prefixlen 64
	echo "$INTERFACE:\\" >> /var/ppp-v6/$INTERFACE_ID.conf
	echo "	:addr=\"$SUBNET::\":prefixlen#64:" >> /var/ppp-v6/$INTERFACE.conf
	rtadvd -D -c /var/ppp-v6/$INTERFACE.conf -p /var/ppp-v6/$INTERFACE.pid $INTERFACE
fi
