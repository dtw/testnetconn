#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
