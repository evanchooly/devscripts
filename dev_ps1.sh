#! /bin/sh

extractSVN() {
	TEXT=$( svn info | grep "$1" )
	echo ${TEXT##$1}
}

findRoot() {
	cd $1
	if [ -e ../.svn ]
	then
		findRoot $( pwd )/..
	else
		pwd
	fi
}

export REPO_PATH=""
export CWD="$( pwd )"
if [ -e .svn ]
then
	URL=`extractSVN "URL: "`
	REPROOT=`extractSVN "Repository Root: "`
	CWD=`findRoot $( pwd )`
	export REPO_PATH="\033[01;33m[svn: ${URL##$REPROOT}]"
elif [ -e CVS ]
then
	export REPO_PATH="\033[01;33m[cvs: $(cat CVS/Repository)]"
	export CWD="`pwd| sed -e \"s|$(cat CVS/Repository)||\"`"
elif [ "`hg root 2> /dev/null`" ]
then
	DIR=`pwd | sed -e "s|$( hg root )||"`
	export CWD=$( hg root )
	#[ "$DIR" ] && DIR=":$DIR"
	export REPO_PATH="\033[01;33m[hg: ($(hg branch))${DIR}]"
else
	export CWD="`pwd| sed -e \"s|${HOME}|~|\"`"
fi

if [ "${REPO_PATH}" ]
then
	echo "${CWD} ${REPO_PATH}"
else
	echo "${CWD}"
fi

