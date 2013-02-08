#! /bin/sh

source $(dirname $0)/dev_base.sh $*

replace() {
    sed -i "" \
        -e "s/@testpackage@/${PACKAGE}/" \
        -e "s/@dashed-name@/${DASHED}/" \
        $1

}
if [ -z "${TEST_NAME}" ]
then
	echo "please define the test name in the env var TEST_NAME"
	exit 1
fi

DASHED=$(echo ${TEST_NAME} | sed -e "s/[A-Z]/-&/g" | tr A-Z a-z)
PACKAGE=$(echo ${TEST_NAME} | tr A-Z a-z)

cd ${APS_HOME}/devtests/web

[ -e ${TEST_NAME} ] && rm -rvf ${TEST_NAME}
cp -R baseDevTestTemplate ${TEST_NAME}
cd ${TEST_NAME}

find . -type f | while read FILE
do
    replace $FILE
done

find . -name .svn | xargs rm -rf 

mkdir src/main/java/org/glassfish/devtests/web/${PACKAGE}
mv *.java src/main/java/org/glassfish/devtests/web/${PACKAGE}

echo created new test in `pwd`
