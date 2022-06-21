curl -k -XPOST -H "Authorization: Basic dGVzdGluZy11c2VyOnRlc3RpbmctdXNlcg==" "https://54dc60343a3b46d3a26840aa77dc46d3.europe-west2.gcp.elastic-cloud.com:9243/_security/user/$1/_password" -H 'Content-Type: application/json' -d '
{
  "password" : "'$2'"
}'
