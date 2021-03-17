#!/bin/sh

# User configurable options
# Note: PREFIX_LEN has to be a multiple of 4 and can't be larger than /48
PREFIX="666:420:69"
PREFIX_LEN=48

# Beyond here is (normally) not user-configurable for non-shell hackers

# Are we larger than /48, if so, exit
if [ $PREFIX_LEN -gt 48 ]
then
	exit 1
fi

# Format PREFIX for our use
PREFIX=`printf '$PREFIX' | sed 's/:://'`
if [ $(( $PREFIX_LEN % 16 )) == 0 ]
then
	PREFIX=`printf '$PREFIX:'`
fi

# Variables for interface ID
INTERFACE=$1
INTERFACE_INT=`echo $INTERFACE | cut -c 3-`
INTERFACE_ID=`printf '%x' $INTERFACE_INT`
PROTO=$2

# Are we out of IPv6 prefixes?
if [ $INTERFACE_ID -gt $(( `echo 2^$INTERFACE_ID | bc` - 1 )) ]
then
	exit 1
fi

# Actually assign the IPv6 prefix
if [ "$PROTO" == "inet6" ]
then
	SUBNET=$PREFIX$INTERFACE_ID
	ifconfig $INTERFACE inet6 $SUBNET::1 prefixlen 64
	echo "$INTERFACE:\\" >> /var/ppp-v6/$INTERFACE_ID.conf
	echo "	:addr=\"$SUBNET::\":prefixlen#64:" >> /var/ppp-v6/$INTERFACE.conf
	rtadvd -D -c /var/ppp-v6/$INTERFACE.conf -p /var/ppp-v6/$INTERFACE.pid $INTERFACE
fi
