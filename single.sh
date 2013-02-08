#! /bin/sh

source $(dirname $0)/dev_base.sh $*

if [ "$1" == "--revert" ]
then
    cp -v ${GF_DEV_HOME}/distributions/glassfish/target/stage/glassfish3/glassfish/domains/domain1/config/domain.xml  $S1AS_HOME/domains/domain1/config/domain.xml
    shift
fi
ant single -Dtarget=$1
