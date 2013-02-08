#! /bin/sh

while [ "$2" ]
do
	SEARCH=$"$SEARCH $1"
	shift
done
echo "grep -Hr \"$SEARCH\" $1 | grep -v .svn"
grep -Hr "$SEARCH" $1 | grep -v .svn
