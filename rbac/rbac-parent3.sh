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
