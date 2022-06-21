#!/bin/bash
echo Password - 'inq123123'  
sshpass -p 'inq123123' ssh -o StrictHostKeyChecking=no ubuntu@155.93.124.31 -v
