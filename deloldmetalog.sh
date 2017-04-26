#!/bin/sh
## This command checks for old log files from the shibboleth
## metadata deployment process and deletes them
/bin/find /var/log/metadata-deployment.*.log -mtime +10 -delete
