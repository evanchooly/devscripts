#! /bin/sh

parseOpts() {
	while [ "$1" ]
	do
		if [ "$1" == "--revert" ]
		then
			echo Only reverting domain.xml
			cp -v ${GF_DEV_HOME}/distributions/glassfish/target/stage/glassfish3/glassfish/domains/domain1/config/domain.xml  $S1AS_HOME/domains/domain1/config/domain.xml
			exit
		elif [ "$1" == "--nobuild" ]
		then
			NOBUILD=NOBUILD
		elif [ "$1" == "--buildonly" ]
		then
			BUILDONLY=BUILDONLY
		elif [ "$1" == "--clean" ]
		then
			CLEAN=clean
		fi
		
		shift
	done
}

source $(dirname $0)/dev_base.sh $*

execMvn() {
	echo ${1}
	${1}
	if [ $? -ne 0 ]
	then
		echo "\n\n\nmaven failed\n\n\n"
		exit
	fi
}

run() {

	parseOpts $*

	DIST=glassfish

	if [ "${CLEAN}" ]
	then
		echo "#######  Cleaning project"
	fi

	if [ -z "${NOBUILD}" ]
	then
		CMD="mvn ${MVN_OPTS} ${CLEAN} install ${SKIP_TEST} -Dmaven.compiler.debug=true"
		echo ${CMD}
		${CMD}
		if [ $? -ne 0 ]
		then
			echo "\n\n\nmaven failed\n\n\n"
			exit
		fi
	fi

	if [ -z "${BUILDONLY}" ]
	then
		rm -rf ${S1AS_HOME}
		unzip -od ${GF_INSTALL} distributions/${DIST}/target/*.zip
	fi
}

SKIP_TEST="-Dmaven.test.skip=true"
cd $GF_DEV_HOME
echo Building from `pwd`

run $* 
