#! /bin/sh

source $(dirname $0)/dev_base.sh $*

updateModule() {
	MOD=$1
	if [ -e ${MOD}/pom.xml ]
	then
		cd ${MOD}
		updateBundle.sh
		cd - > /dev/null
	fi
}

#cd ${GF_DEV_HOME}
CHANGED=`changed.sh | grep -v '#' | cut -c 2- | sed -e 's/src\/.*//' -e 's/pom.xml//' | sort | uniq`
echo rebundling ${CHANGED}

for CHANGE in ${CHANGED}
do
	updateModule ${CHANGE}
done

if [ "$1" == "--start" ]
then
	echo press enter to start the server.  ^C to stop.
	read
	$S1AS_HOME/bin/asadmin start-domain --verbose --debug
fi
