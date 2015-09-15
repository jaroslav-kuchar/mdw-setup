#!/bin/bash

# Generate scripts 
# @author Jaroslav Kuchař

# http://stackoverflow.com/a/21188136
get_abs_filename() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

###################################################################################################
# settings
###################################################################################################
USER="vagrant"
USER_GROUP="vagrant"
JAVA="/usr/lib/jvm/java-7-oracle/"
BASE_DIR=$(pwd);
SCRIPTS_HOME="${BASE_DIR}"
WLS_INSTALLER=$(get_abs_filename "${BASE_DIR}/../oracle_install/wls.jar")
OSB_INSTALLER=$(get_abs_filename "${BASE_DIR}/../oracle_install/osb/Disk1/runInstaller")
MIDDLEWARE_HOME=$(get_abs_filename "${BASE_DIR}/../oracle_mw")
DOMAIN_HOME="${MIDDLEWARE_HOME}/user_projects/domains/base_domain"
TEMPLATE="${SCRIPTS_HOME}/mi-mdw_10.3.6.0.jar"

###################################################################################################
# oraInst
###################################################################################################
echo "oraInst.loc"
oraInst=$(cat <<EOF
inst_group=${USER_GROUP}
inventory_loc=${MIDDLEWARE_HOME}/orainventory
EOF
);
echo "$oraInst" > "${SCRIPTS_HOME}/oraInst.loc"


###################################################################################################
# osb-silent.rsp
###################################################################################################
echo "osb-silent.rsp"
osbsilent=$(cat <<EOF
[ENGINE]
Response File Version=1.0.0.0.0
[GENERIC]
SKIP_SOFTWARE_UPDATES=true
TYPICAL TYPE=false
CUSTOM TYPE=true
Oracle Service Bus Examples=true
Oracle Service Bus IDE=false
ORACLE_HOME=${MIDDLEWARE_HOME}/Oracle_OSB1
MIDDLEWARE_HOME=${MIDDLEWARE_HOME}
WL_HOME=${MIDDLEWARE_HOME}/wlserver
[SYSTEM]
[APPLICATIONS]
[RELATIONSHIPS]
EOF
);
echo "$osbsilent" > "${SCRIPTS_HOME}/osb-silent.rsp"


###################################################################################################
# osb-silent.sh
###################################################################################################
echo "osb-silent.sh"
osbsilent=$(cat <<EOF
#!/bin/bash
${OSB_INSTALLER} -silent -responseFile ${SCRIPTS_HOME}/osb-silent.rsp -invPtrLoc ${SCRIPTS_HOME}/oraInst.loc -jreLoc ${JAVA}
EOF
);
echo "$osbsilent" > "${SCRIPTS_HOME}/osb-silent.sh"
chmod +x "${SCRIPTS_HOME}/osb-silent.sh"


###################################################################################################
# wls-domain.sh
###################################################################################################
echo "wls-domain.sh"
wlsdomain=$(cat <<EOF
#!/bin/bash
mkdir -p ${DOMAIN_HOME}
${MIDDLEWARE_HOME}/wlserver/common/bin/unpack.sh -template=${TEMPLATE} -domain=${DOMAIN_HOME} -java_home=${JAVA}	
EOF
);
echo "$wlsdomain" > "${SCRIPTS_HOME}/wls-domain.sh"
chmod +x "${SCRIPTS_HOME}/wls-domain.sh"

###################################################################################################
# wls-silent.rsp
###################################################################################################
echo "wls-silent.rsp"
wlssilent=$(cat <<EOF
[ENGINE]
 
#DO NOT CHANGE THIS.
Response File Version=1.0.0.0.0
 
[GENERIC]
 
#The oracle home location. This can be an existing Oracle Home or a new Oracle Home
ORACLE_HOME=${MIDDLEWARE_HOME}
 
#Set this variable value to the Installation Type selected. e.g. WebLogic Server, Coherence, Complete with Examples.
INSTALL_TYPE=WebLogic Server
 
#Provide the My Oracle Support Username. If you wish to ignore Oracle Configuration Manager configuration provide empty string for user name.
MYORACLESUPPORT_USERNAME=
 
#Provide the My Oracle Support Password
MYORACLESUPPORT_PASSWORD=<SECURE VALUE>
 
#Set this to true if you wish to decline the security updates. Setting this to true and providing empty string for My Oracle Support username will ignore the Oracle Configuration Manager configuration
DECLINE_SECURITY_UPDATES=true
 
#Set this to true if My Oracle Support Password is specified
SECURITY_UPDATES_VIA_MYORACLESUPPORT=false
 
#Provide the Proxy Host
PROXY_HOST=
 
#Provide the Proxy Port
PROXY_PORT=
 
#Provide the Proxy Username
PROXY_USER=
 
#Provide the Proxy Password
PROXY_PWD=<SECURE VALUE>
 
#Type String (URL format) Indicates the OCM Repeater URL which should be of the format [scheme[Http/Https]]://[repeater host]:[repeater port]
COLLECTOR_SUPPORTHUB_URL=
EOF
);
echo "$wlssilent" > "${SCRIPTS_HOME}/wls-silent.rsp"


###################################################################################################
# wls-silent.sh
###################################################################################################
echo "wls-silent.sh"
wlssilent=$(cat <<EOF
#!/bin/bash
rm -rf ${MIDDLEWARE_HOME}
mkdir -m 777 -p ${MIDDLEWARE_HOME}
java -jar ${WLS_INSTALLER} -mode=silent -silent_xml=${SCRIPTS_HOME}/wls-silent.xml -responseFile=${SCRIPTS_HOME}/wls-silent.rsp -Djava.security.egd=file:/dev/./urandom	
chown -R ${USER}:${USER_GROUP} ${MIDDLEWARE_HOME}
EOF
);
echo "$wlssilent" > "${SCRIPTS_HOME}/wls-silent.sh"
chmod +x "${SCRIPTS_HOME}/wls-silent.sh"


###################################################################################################
# wls-silent.xml
###################################################################################################
echo "wls-silent.xml"
wlssilent=$(cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
   <bea-installer> 
     <input-fields>
       <data-value name="BEAHOME" value="${MIDDLEWARE_HOME}" />
       <data-value name="WLS_INSTALL_DIR" value="${MIDDLEWARE_HOME}/wlserver" />
       <data-value name="OCP_INSTALL_DIR" value="${MIDDLEWARE_HOME}/coherence" />
       <data-value name="NODEMGR_PORT" value="5556" />
       <data-value name="INSTALL_SHORTCUT_IN_ALL_USERS_FOLDER" value="true"/>
   </input-fields> 
</bea-installer>
EOF
);
echo "$wlssilent" > "${SCRIPTS_HOME}/wls-silent.xml"

