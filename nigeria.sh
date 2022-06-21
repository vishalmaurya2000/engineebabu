#!/bin/bash
echo Password - "inq4@1234" 
sshpass -p 'inq4@1234' ssh -o StrictHostKeyChecking=no inq321@10.206.3.124 -v
