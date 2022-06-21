#!/bin/bash
echo Password - "naf123!" && sshpass -p 'naf123!' ssh -o StrictHostKeyChecking=no nafadmin@155.93.92.186 -v
