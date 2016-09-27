#!/bin/sh
# start-cron.sh

rsyslogd
cron
touch /var/log/cron.log
tail -f /usr/local/go/src/log/syslog /var/log/cron.log
