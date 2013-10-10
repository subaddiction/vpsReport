#!/bin/bash

#General settings
SENDER="root@bquery.com"
RECIPIENT="mrk25@bquery.com"

echo "From: $SENDER" > report.log
echo "To: $RECIPIENT" >> report.log
echo "Subject: $(hostname) server report" >> report.log

#Disk usage
DU_WEB=$(du -ah --max-depth 1 /var/www)
DU_USERS=$(du -ah --max-depth 1 /home)
DU_LOGS=$(du -ah --max-depth 1 /var/log)
DU_MYSQL=$(du -ah --max-depth 1 /var/lib/mysql/)
DU_TOTAL=$(df -ah)

FIREWALL=$(iptables --list)
CONNECTIONS=$(netstat -nap)
TOP=$(top -bcHS -n1)
PSTREE=$(pstree -alcp)
DU_TOTAL="$(df -ah)"

echo "\n$(hostname) server report\n\n----------------\n\n" >> report.log
echo "--DISK USAGE--" >> report.log
echo "\n\n--WEB--------------\n\n" >> report.log
echo "$DU_WEB" >> report.log
echo "\n\n--USERS--------------\n\n" >> report.log
echo "$DU_USERS" >> report.log
echo "\n\n--MYSQL--------------\n\n" >> report.log
echo "$DU_MYSQL" >> report.log
echo "\n\n--LOGS--------------\n\n" >> report.log
echo "$DU_LOGS" >> report.log
echo "\n\n--TOTAL--------------\n\n" >> report.log
echo "$DU_TOTAL" >> report.log
echo "\n\n----------------\n\n" >> report.log
echo "--ACTIVITY--" >> report.log
echo "\n\n--FIREWALL--------------\n\n" >> report.log
echo "$FIREWALL" >> report.log
echo "\n\n--CONNECTIONS--------------\n\n" >> report.log
echo "$CONNECTIONS" >> report.log
echo "\n\n--STATUS--------------\n\n" >> report.log
echo "$TOP" >> report.log
echo "\n\n--PROCESS TREE--------------\n\n" >> report.log
echo "$PSTREE" >> report.log
echo "\n\n----------------\n\n" >> report.log

# mail notification
/usr/sbin/sendmail -f$SENDER $RECIPIENT < report.log
