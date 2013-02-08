#! /bin/sh

if [ -z "${GF_INSTALL}" ] 
then 
	echo "please define env var GF_INSTALL and point it to your GF install dir." 
	echo "e.g., if you want glassfish to live in ~/dev/glassfish3 then GF_INSTALL should be set to ~/dev"
	echo "anything in this directory will be deleted in the distro script so make sure it's a dedicated directory"
	exit 1
fi

if [ -z "${GF_DEV_HOME}" ] 
then 
	echo "please define the GF_DEV_HOME variable and point it to your GF dev root dir.  This should point to the"
    echo "v3 directory of your subversion workspace for glassfish."
    echo "e.g., ~/dev/glassfish/v3"
	exit 1
fi

if [ `expr "$*" : "--v2"` -gt 0 -a -z "${V2_INSTALL}" ] 
then 
	echo "please define the V2_INSTALL variable and point it to your GF install dir."
	echo "e.g., if you want glassfish to live in ~/dev/glassfish3 then GF_INSTALL should be set to ~/dev"
	echo "anything in this directory will be deleted in the distro script so make sure it's a dedicated directory"
	exit 1
fi

if [ -z "${APS_HOME}" ]
then
    echo "please define the APS_HOME variable to point root of appserv tests tree."
    echo "e.g., ~/dev/glassfish/v2/appserv-tests"
fi
