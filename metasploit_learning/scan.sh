#!/bin/bash

TARGET_IP=${1:-"185.171.82.223"}
RESOURCE_FILE="/tmp/msf_scan.rc"

echo "Target: $TARGET_IP"
echo "Start scan..."

cat > $RESOURCE_FILE << EOF
db_connect msf@127.0.0.1/msf

use auxiliary/scanner/portscan/tcp
set RHOSTS $TARGET_IP
set PORTS 1-100
run

use auxiliary/scanner/http/http_version
set RHOSTS $TARGET_IP
run

use auxiliary/scanner/http/dir_scanner
set RHOSTS $TARGET_IP
set RPORT 80
run

use auxiliary/scanner/http/backup_file
set RHOSTS $TARGET_IP
run

exit
EOF

msfconsole -r $RESOURCE_FILE

rm -f $RESOURCE_FILE
echo "Done"
