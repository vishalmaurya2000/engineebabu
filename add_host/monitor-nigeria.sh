#!/bin/bash
echo "" > monitor.yml
for x in $(cat host.csv)
do
echo "- type: icmp
  id: $(echo $x| cut -d ',' -f1)
  name: $(echo $x|cut -d ',' -f1)
  schedule: '@every 60s'
  hosts: [$(echo $x| cut -d ',' -f2)]
  timeout: 10s
  wait: 1s
  tags: [BTS]" >> monitor.yml
done
