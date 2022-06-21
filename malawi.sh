#!/bin/bash
echo Password - 'R3@L~$3cr3t!321'  
sshpass -p 'R3@L~$3cr3t!321' ssh -o StrictHostKeyChecking=no s-manage@41.75.114.37 -v
