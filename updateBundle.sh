#! /bin/sh

source $(dirname $0)/dev_base.sh $*

updateJar() {
	SRCJAR=`\ls target/*.jar | grep -vi -- -sources.jar | grep -v -- -tests.jar | grep -v -- -javadoc.jar`
	JAR=`echo ${SRCJAR} | sed -e 's/-*[0-9]\..*jar/.jar/'`
	JAR=${JAR//target\//}
	DEST=$S1AS_HOME/modules/${JAR}
	if [ -e $DEST ]
	then
		echo mv -v ${SRCJAR} ${DEST}
		mv -v ${SRCJAR} ${DEST}
	else
		echo Destination doesn\'t exist.  This is probably a bug in the script.
		echo Tried to map ${SRCJAR} to ${JAR}
		echo but ${JAR} doesn\'t exist in the echo modules directory of
		echo your glassfish installation.
	fi
}

mvn ${MVN_OPTS} install -Dmaven.test.skip=true || exit
updateJar
