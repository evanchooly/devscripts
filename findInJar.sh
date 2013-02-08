#! /bin/sh

echo
echo
echo
echo
echo
echo
echo
for i in `find . -name "*.jar" -o -name "*.zip"`
do
	if [ -f $i ]
	then
		export ENTRY=`jar -tf $i | grep -i $1`
		if [ -n "${ENTRY}" ] 
		then
			echo $i
			echo "********************************************************"
			echo "${ENTRY}"
			echo
			echo
			echo
		fi
	fi
done
