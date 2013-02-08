#! /bin/sh

source $(dirname $0)/dev_base.sh $*

cd ${GF_DEV_HOME}/tests/quicklook
pwd
if [ "$1" == "--debug" ]
then
	CMD="mvnDebug -DforkMode=none"
else
	CMD="mvn"
fi

${CMD} -Dglassfish.home=$S1AS_HOME -Djava.awt.headless=true test | tee run.log
