#!/bin/bash
#usage="Usage: bash add-host.sh -u client-name -p password -c circuit-id -s spacename"
while getopts u:p:h option;
do
        case $option in
                u) clientname=$OPTARG;;
                p) pass=$OPTARG;;
                h) echo "$usage"
                exit $invalid_result;;
        esac
done
if [[ -z $clientname || -z $pass ]]; then
 # echo "$usage"
  exit 0
fi
## user check
user=$(curl -sk -XGET -H "Authorization: Basic dGVzdGluZy11c2VyOnRlc3RpbmctdXNlcg==" https://54dc60343a3b46d3a26840aa77dc46d3.europe-west2.gcp.elastic-cloud.com:9243/_security/user | jq . | grep username | cut -d '"' -f4 | grep -iw "$clientname" | wc -l)
if [ $user -eq 0 ] 
then
	echo -n "user-not-exist"
	exit 0 
fi
bash /var/www/rbac/reset-user.sh $clientname $pass 
echo "password-updated"
