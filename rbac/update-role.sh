#!/bin/bash
#usage="Usage: bash add-host.sh -u client-name -p password -c circuit-id -s spacename"
while getopts u:s:c:h option;
do
        case $option in
                u) clientname=$OPTARG;;
		s) space=$OPTARG;;
		c) circuitid=$OPTARG;;
                h) echo "$usage"
                exit $invalid_result;;
        esac
done
if [[ -z $clientname || -z $space || -z $circuitid ]]; then
 # echo "$usage"
  exit 0
fi
## user check
user=$(curl -sk -XGET -H "Authorization: Basic dGVzdGluZy11c2VyOnRlc3RpbmctdXNlcg==" https://54dc60343a3b46d3a26840aa77dc46d3.europe-west2.gcp.elastic-cloud.com:9243/_security/role | jq . | cut -d ":" -f1 | cut -d '"' -f2 | grep $clientname | wc -l)
if [ $user -le 0 ] 
then
	echo "role-not-exist"
	exit 0 
fi

id=$(echo $circuitid | sed 's/[^,]//g' | wc -c)
cp /var/www/rbac/rbac-parent3.sh /var/www/rbac/part1.sh
for i in $(seq 1 $id)
do
	val=$(echo $circuitid | cut -d "," -f $i)

	echo '{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*'$val'*"
                                        }
				},' >> /var/www/rbac/part1.sh
done
sed -i '$ d' /var/www/rbac/part1.sh
echo "}" >> /var/www/rbac/part1.sh
cat /var/www/rbac/part2 >> /var/www/rbac/part1.sh
bash /var/www/rbac/part1.sh $clientname $space
echo "role-updated:"
