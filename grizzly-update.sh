#! /bin/sh
NEWVER=$1

if [ -z "${NEWVER}" ]
then
	echo Please specify the new version as a parameter
	exit
fi

asadmin stop-domain
for i in grizzly-*
do
	DEP=${i/.jar/}
	if [ -f ~/.m2/repository/com/sun/grizzly/${DEP}/${NEWVER}/${DEP}-${NEWVER}.jar ]
	then
		cp ~/.m2/repository/com/sun/grizzly/${DEP}/${NEWVER}/${DEP}-${NEWVER}.jar .
	else
		wget http://download.java.net/maven/glassfish/com/sun/grizzly/${DEP}/${NEWVER}/${DEP}-${NEWVER}.jar
	fi
	[ $? -eq 0 ] && mv -v ${DEP}-${NEWVER}.jar $i
done

rm -r ../domains/domain1/osgi-cache/felix/

#asadmin start-domain
echo You can start GlassFish with ${NEWVER} now.
