#! /bin/sh

source $(dirname $0)/dev_base.sh $*
BASE_PORT=40000

replace() {
	sed -i .bak -e "s/$1=.*/$1=$2/" config.properties
}

WEBTIER_ADMIN_PORT=$[ ${BASE_PORT} + 1 ]
WEBTIER_PORT=$[ ${BASE_PORT} + 2 ]
WEBTIER_SSL_PORT=$[ ${BASE_PORT} + 3 ]
WEBTIER_ALTERNATE_PORT=$[ ${BASE_PORT} + 4 ]
WEBTIER_ORB_PORT=$[ ${BASE_PORT} + 5 ]
WEBTIER_ORB_SSL_PORT=$[ ${BASE_PORT} + 6 ]
WEBTIER_ORB_SSL_MUTUALAUTH_PORT=$[ ${BASE_PORT} + 7 ]
WEBTIER_JMS_PORT=$[ ${BASE_PORT} + 8 ]
JMX_PORT=$[ ${BASE_PORT} + 9 ]

clear
pushd ${APS_HOME}

replace admin.port ${WEBTIER_ADMIN_PORT}
replace http.port ${WEBTIER_PORT}
replace https.port ${WEBTIER_SSL_PORT}
replace http.alternate.port ${WEBTIER_ALTERNATE_PORT}
replace orb.port ${WEBTIER_ORB_PORT}

echo "AS_ADMIN_PASSWORD=" > temppwd
$S1AS_HOME/bin/asadmin delete-domain domain1
$S1AS_HOME/bin/asadmin --user admin --passwordfile $APS_HOME/temppwd --echo=true create-domain --adminport ${WEBTIER_ADMIN_PORT} --domainproperties jms.port=${WEBTIER_JMS_PORT}:domain.jmxPort=${JMX_PORT}:orb.listener.port=${WEBTIER_ORB_PORT}:http.ssl.port=${WEBTIER_SSL_PORT}:orb.ssl.port=${WEBTIER_ORB_SSL_PORT}:orb.mutualauth.port=${WEBTIER_ORB_SSL_MUTUALAUTH_PORT} --instanceport ${WEBTIER_PORT} domain1

pushd $APS_HOME/devtests/web

./exclude-jobs.sh
[ "$1" ] && PARAM="single -Dtarget=$1 finish-report"
ant ${PARAM}

popd
svn revert config.properties
popd

[ -f $APS_HOME/test_results.html ] && open $APS_HOME/test_results.html 
