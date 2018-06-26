#!/bin/sh

ep /etc/rsyslog-remote.conf

# check if we can connect to the given Host and Port
# If yes we send our syslog messages there.
if nc -z -w 1 ${RSYSLOG_TCP_HOST:-syslog.lagoon.svc} ${RSYSLOG_TCP_PORT:-5140} &> /dev/null; then
  rsyslogd -i /tmp/rsyslogd.pid -n -f /etc/rsyslog-remote.conf &
else
  rsyslogd -i /tmp/rsyslogd.pid -n -f /etc/rsyslog.conf &
fi