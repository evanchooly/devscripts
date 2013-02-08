#! /bin/sh

source $(dirname $0)/dev_base.sh $*

GFPATH=${S1AS_HOME}/bin

process() {
	while [ "$1" != "" ]
	do
		if [ "$1" == "--v2" ]
		then
			GFPATH=${V2_INSTALL}/bin
		elif [ "$1" == "--debug" ]
		then
			DEBUG=true
			PARAMS="${PARAMS} --debug"
		else
			PARAMS="${PARAMS} $1"
		fi
		shift
	done
	XML=$GFPATH/../domains/domain1/config/domain.xml
	rm -f ${XML}.bak
	if [ "${DEBUG}" -a "`grep suspend=n ${XML}`" ]
	then
		sed -i .bak -e "s/suspend=n/suspend=y/g" ${XML}
	#else
		#sed -i .bak -e "s/suspend=y/suspend=n/g" ${XML}
	fi
	echo ${GFPATH}/asadmin start-domain ${PARAMS} $*
	${GFPATH}/asadmin start-domain ${PARAMS} $*
}

process $*
