#!/bin/bash
#Shibboleth Rolling Restart Script
RECIP="email address"
echo "Scheduled rolling restart in progress" > /var/www/html/A10healthCheck/a10_check.html
sleep 30
/sbin/service tomcat restart
sleep 300
echo "A10_Passed_healthCheck" > /var/www/html/A10healthCheck/a10_check.html
TCPID=`ps aux |grep org.apache.catalina.startup.Bootstrap |grep -v grep |awk '{ print $2 }'`
HTPID=`pgrep httpd |head -1`
A10HC=`cat /var/www/html/A10healthCheck/a10_check.html`
mail -s "$HOSTNAME -Tomcat Rolling Restart Complete" $RECIP <<-EOF
Tomcat PID is $TCPID
Apache PID is $HTPID
A10 health check file content is $A10HC
EOF
exit
