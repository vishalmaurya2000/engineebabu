#!/bin/bash
curl -k -XPUT -H "Authorization: Basic dGVzdGluZy11c2VyOnRlc3RpbmctdXNlcg==" "https://54dc60343a3b46d3a26840aa77dc46d3.europe-west2.gcp.elastic-cloud.com:9243/_security/role/$1" -H 'Content-Type: application/json' -d '
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
				"should": [
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NB IGANMU INTERNET - NG.VLK.00204*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL - NG.AIR.07186*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL - NG.AIR.07188*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL - NG.VLK.09527*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL EXEC - NG.CXO.00004*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL HEAD OFFICE - NG.MTB.01479*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL IDU - NG.AIR.07073*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL IDU - NG.MTB.01479*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL - NG.MTB.00835*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL - NG.VLK.09508*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL EXEC - NG.CXO.00018*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL RESIDENCE - NG.VLK.09524*"
                                        }
				},
{
	                                       "wildcard": {
                                                "interfaces.ifAlias.keyword": "*NBL RESIDENCE - NG.VLK.09524_STOPGAP*"
                                        }
}
                                ],
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
                        "space:'$2'"
                ]
        }]
}'

