#!/bin/sh

ep /etc/rsyslog.conf
ep /etc/rsyslog.d/*

if [ "${SYSLOG_STDOUT}" == "TRUE" ]; then
  mv /etc/rsyslog.d/stdout.conf.disabled /etc/rsyslog.d/stdout.conf
fi