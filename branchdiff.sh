#! /bin/sh

BRANCH=$1
shift
FILE=`find . -name "$*"`

#echo diff "${FILE}" ${BRANCH}/"${FILE}"
diff -wb "${FILE}" ${BRANCH}/"${FILE}"

#echo to copy:  cp "${FILE}" ${BRANCH}/"${FILE}"
