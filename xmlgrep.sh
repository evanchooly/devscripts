#! /bin/sh

source $(dirname $0)/dev_base.sh $*

[ -s ${S1AS_HOME}/domains/domain1/config/domain.xml ] && (sgrep2 "\"<$1>\" .. \"</$1>\"" ${S1AS_HOME}/domains/domain1/config/domain.xml | tidy -q -xml -i -w 120000 -) | head -n 39
