#!/bin/sh
#set -x
################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "################################################################################"
   echo "################################################################################"
   echo "Function to remove cache from cloudflare."
   echo
   echo "Variabled to provide:"
   echo "CLOUDFLARE_ZONE_ID"
   echo "CLOUDFLARE_EMAIL"
   echo "CLOUDFLARE_API_KEY"
   echo
   echo "Optional: DEBUG=true. if the variable is set, the script will display more things"
   echo
   echo "Syntax: clear-cache <purge_everything|hosts|tags|files|prefixes> <list_of_resources>"
   echo "ex:"
   echo "clear-cache files \"[\\\"https://mydomain.org/a/b/c.txt\\\",\\\"https://mydomain.org/X/Y/myfile.csv\\\"]\\\""
   echo
   echo 
   echo "################################################################################"
}

if [ -z "$CLOUDFLARE_ZONE_ID" ]; then echo "CLOUDFLARE_ZONE_ID environment variable NOT set"; Help; exit 1; fi
if [ -z "$CLOUDFLARE_EMAIL" ]; then echo "CLOUDFLARE_EMAIL environment variable NOT set"; Help; exit 1; fi
if [ -z "$CLOUDFLARE_API_KEY" ]; then echo "CLOUDFLARE_API_KEY environment variable NOT set"; Help; exit 1; fi
if [ -z "$1" ]; then echo "Resource type not provided (first arg)"; Help; exit 1; fi
if [ -z "$2" ]; then echo "Resource list not provided (second arg)"; Help; exit 1; fi


################################################################################
################################################################################
# Main program                                                                 #
################################################################################
################################################################################

RESOURCE_TYPE=$1
RESOURCE_LIST=$2

if [ "$DEBUG" == "true" ]
then
  echo "################################################################################"
  echo "# DEBUG activated                                                              #"
  echo "################################################################################"
  echo "Configuration: "
  echo "CLOUDFLARE_ZONE_ID: $CLOUDFLARE_ZONE_ID"
  echo "CLOUDFLARE_EMAIL: $CLOUDFLARE_EMAIL"
  echo "CLOUDFLARE_API_KEY: ${CLOUDFLARE_API_KEY:0:5}************"
  echo "RESOURCE_TYPE: $RESOURCE_TYPE"
  echo "RESOURCE_LIST: $RESOURCE_LIST"
  echo "################################################################################"
  echo 
  echo
fi

echo "################################################################################"
echo "# Result:                                                                      #"
echo "################################################################################"
echo

curl -X POST https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/purge_cache \
 -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
 -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
 -H "Content-Type: application/json" \
 --data "{\"$RESOURCE_TYPE\":$RESOURCE_LIST}"
