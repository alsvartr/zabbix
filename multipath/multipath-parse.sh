#!/bin/bash

ALIAS=$1
STATUS=$2

if [ $STATUS == "active" ]; then
	STATUS="active ready|ghost"
elif [ $STATUS == "all" ]; then
	STATUS=""
else
	echo "ZBX_NOTSUPPORTED"
	exit 0
fi

startparse="0"
pthcnt="0"
while read line
do
	if [ $startparse = "0" ]; then
		isalias=`echo $line | grep -cE "^$ALIAS "`
		if [ $isalias = "1" ]; then
			startparse="1"
			stopparse="0"
		fi
	else
		stopparse=`echo $line | grep -cE "^.*\(.*\).*$"`
		if [ $stopparse = "1" ]; then
			break
		fi

		isactive=`echo $line | grep -cE "([0-9]+:){3}.*$STATUS"`
		if [ $isactive = "1" ]; then
			pthcnt=$((pthcnt+1))
		fi
	fi
done < /tmp/multipath-ll-v2

echo $pthcnt
