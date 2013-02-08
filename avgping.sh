#! /bin/sh

avg() {
	display "$1 => $(/sbin/ping -c 10 $1 | grep avg | cut -d/ -f5)"
}

growl() {
	/usr/local/bin/growlnotify "${1}"
}

display() {
	if [ "${MAILTO}" ]
	then
		growl "${1}"
	else
		echo "${1}"
	fi
}

avg antwerkz.com &
PID=$!
avg skype.com &
PID="${PID} $!"
avg netflix.com &
PID="${PID} $!"

if [ -z "${MAILTO}" ]
then
	wait ${PID}
fi
