#!/bin/bash
#bakerx delete vm app-vm
ssh_cmd=$(bakerx run app-vm alpine3.9-simple | tail -1)
$ssh_cmd << 'END_DOC'

apk add --update --no-cache nodejs npm git
git clone https://github.com/CSC-DevOps/App
cd App
npm install
ifconfig | grep 'eth1' -A 1
exit
END_DOC

echo $ssh_cmd
