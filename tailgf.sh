#! /bin/bash

source `dirname $0`/dev_base.sh $*

if [ "$1" == "--v2" ]
then
	GFPATH=${V2_INSTALL}
	shift
else
	GFPATH=${S1AS_HOME}
fi

FILE=$GFPATH/domains/domain1/logs/server.log
[ -z "`ps uxw | grep java | grep -v grep | grep domaindir`" ] && > ${FILE}
echo tailing ${FILE}
tail -f ${FILE}
