curl -k -XPOST -H "Authorization: Basic dGVzdGluZy11c2VyOnRlc3RpbmctdXNlcg==" "https://54dc60343a3b46d3a26840aa77dc46d3.europe-west2.gcp.elastic-cloud.com:9243/_security/role/$1" -H 'Content-Type: application/json' -d '
{
	"indices": [{
		"names": [
			"inq-nigeria-snmp-*"
		],
		"privileges": [
			"read",
			"view_index_metadata"
		],
		"field_security": {
			"grant": [
				"*"
			],
			"except": []
		},
		"query": {
			"bool": {
				"should": [{
					"wildcard": {
						"interfaces.ifAlias.keyword": "*'$2'*"
					}
				}],
				"must_not": [{
						"wildcard": {
							"interfaces.ifAlias.keyword": "*MGNT*"
						}
					},
					{
						"wildcard": {
							"interfaces.ifAlias.keyword": "*mgnt*"
						}
					},
					{
						"wildcard": {
							"interfaces.ifAlias.keyword": "*mgmt*"
						}
					},
					{
						"wildcard": {
							"interfaces.ifAlias.keyword": "*MGMT*"
						}
					},
					{
						"wildcard": {
							"interfaces.ifAlias.keyword": "*MANAGEMENT*"
						}
					},
					{
						"wildcard": {
							"interfaces.ifAlias.keyword": "*Management*"
						}
					},
					{
						"wildcard": {
							"interfaces.ifAlias.keyword": "*management*"
						}
					}
				]
			}
		},
		"allow_restricted_indices": false
	}],
	"applications": [{
		"application": "kibana-.kibana",
		"privileges": [
			"feature_discover.read",
			"feature_dashboard.read"
		],
		"resources": [
			"space:'$3'"
		]
	}]
}'

