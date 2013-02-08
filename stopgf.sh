#! /bin/sh

source `dirname $0`/dev_base.sh $*

if [ "$1" == "--v2" ]
then
	GFPATH=${V2_INSTALL}/bin
	shift
else
	GFPATH=${S1AS_HOME}/bin
fi

${GFPATH}/asadmin stop-domain 
