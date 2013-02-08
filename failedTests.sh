#! /bin/sh

[ "$1" == "--run" ] || ONLY="-only"
[ -e pom.xml ] && mkdir -p target
mvn surefire-report:report${ONLY} | tee target/maven.out

URLS=""
for target in `find . -name surefire-reports -type d`
do
	echo Scanning ${target} for failures
	for i in `grep -Hr "\(Failures\|Errors\): [1-9]" ${target} | cut -d: -f1`
	do
		if [ "`echo $i | grep surefire`" ]
		then
			URL="`pwd`/`echo $i | sed -e 's/surefire-reports.*/site\/surefire-report.html/'`"
			if [ -z "`echo ${URLS} | grep ${URL}`" ] 
			then
				export URLS="${URLS} ${URL}" 
				echo "found failure in $i"
			fi
		fi
	done
done
[ "${URLS}" ] && open ${URLS}
