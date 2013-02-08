#! /bin/sh

FILE=${APS_HOME}/test_results.xml

failed() {
	echo $(grep value=\"fail\" ${FILE} | wc -l)
}

lastLine() {
	echo `tail -n 1 tracking.skip`
}

trimLast() {
    sed '$d' < tracking.skip > tracking.skip.updated
    mv tracking.skip.updated tracking.skip
}

while [ "`failed`" -eq "0" -a "`lastLine`" != "" ]
do
	[ ! -f build.xml.save ] && cp -v build.xml build.xml.save
	echo Removing `lastLine`
    trimLast
	distro.sh --nobuild && cp build.xml.save build.xml &&  JOB_NAME=tracking devtests.sh
done

