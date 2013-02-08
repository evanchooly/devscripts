#! /bin/sh

COUNT=8
VID=10040
while [ $COUNT -gt 0 ]
do
	echo $COUNT
	wget -q -O /dev/null "http://java.net/jira/secure/project/VersionUp.jspa?versionId=${VID}&pid=10005"
	COUNT=$[ $COUNT - 1 ]
done
