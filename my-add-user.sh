#!/bin/bash 

# ref: https://unix.stackexchange.com/questions/1316/convert-ascii-code-to-hexadecimal-in-unix-shell-script

if [ $# -lt 3 ]; then
    echo "Usage: $(basename $0) <USERNAME> <REALM> <PASSWORD>"
    #exit 1
fi

OUT_MD5=""
function generateMD5() {
    OUT_MD5=""
    echo "---> Your input: $1"
    OUT_MD5=`echo -n "$1" | md5sum | awk '{print $1}'`
    echo "===> MD5 output: ${OUT_MD5}"
}

# By default the properties realm expects the entries to be in the format: -
# username=HEX( MD5( username ':' realm ':' password))
#REALM="odata,rest"
USERNAME=${1:-user1}
REALM=${2:-ApplicationRealm}
PASSWORD=${3:-Password12345_}
STR_USER2MD5="${USERNAME}:${REALM}:${PASSWORD}"

# Added user 'application' to file '/opt/jboss/wildfly/standalone/configuration/application-users.properties'
# Added user 'application' to file '/opt/jboss/wildfly/domain/configuration/application-users.properties'
# Added user 'application' with groups odata,rest to file '/opt/jboss/wildfly/standalone/configuration/application-roles.properties'
# Added user 'application' with groups odata,rest to file '/opt/jboss/wildfly/domain/configuration/application-roles.properties'

# generateMD5 "string"
# generateMD5 "this"
# generateMD5 "this:realm:test"
# generateMD5 "application:ApplicationRealm:password123$"
# generateMD5 "application:ApplicationRealm:Password123$"
# generateMD5 "${USERNAME}:${REALM}:${PASSWORD}"
generateMD5 "${STR_USER2MD5}"

# echo application=e502d26955c72d5070da0c506f5622fa
echo admin=0c78716dc280619097d8796d607ae6ae
#echo -n "$STR2MD5" |xxd -p 
#echo -n "Dump and Revert" |xxd -p |xxd -r
