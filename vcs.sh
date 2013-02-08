#! /bin/sh

scan() {
	if [ -d .git ]
	then
		CMD=git
	elif [ -d .hg ] 
	then
		CMD=hg
	elif [ -d .svn ]
	then
		CMD=svn
	fi

	if [ -z "$CMD" ]
	then
		if [ "`pwd`" != "/" ]
		then
			cd ..
			scan "$1"
		else
			echo No VCS control directory found
			exit
		fi
	fi
}

check() {
	echo "##### using ${CMD} #####"
	if [ "$CMD" != "git" ]
	then
		${CMD} status | grep $* | sort
	elif [ "$CMD" == "git" ]
	then
		if [ "$1" == "-v ?" ]
		then
			${CMD} status | grep -e modified -e renamed -e deleted -e "new file" \
                | sed -e "s/#	modified: /M /" \
                -e "s/#	deleted: /D /" \
                -e "s/#	new file: /A /"
		else
			${CMD} status 2>&1 | grep -e "^#	"  | grep -v ":" | cut -c3-
		fi
	fi
}

scan "$1"
check "$1"
