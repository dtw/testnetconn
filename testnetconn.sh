#!/bin/bash

[ -e /etc/testnetconn.conf ] && source /etc/testnetconn.conf
[ -e $HOME/.testnetconn/testnetconn.conf ] && source $HOME/.testnetconn/testnetconn.conf

PING_FAIL=0

for PING_TGT in ${HOSTS[@]}
do
	$PING -c $PING_ATTEMPTS $PING_TGT > /dev/null
	if [ $? != 0 ] ; then
		PING_FAIL=$(($PING_FAIL+1))
	fi
done
if [ $PING_FAIL -eq ${#HOSTS[@]} ]; then
	logger -p daemon.info -t testnetconn Ping test failed
	logger -p daemon.info -t testnetconn Restarting network connection
	$NET_CMD
fi
exit
