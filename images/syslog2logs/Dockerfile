ARG IMAGE_REPO
FROM ${IMAGE_REPO:-lagoon}/commons as commons
FROM alpine

MAINTAINER amazee.io
ENV LAGOON=syslog2logs

# Copying commons files
COPY --from=commons /lagoon /lagoon
COPY --from=commons /bin/fix-permissions /bin/ep /bin/docker-sleep /bin/
COPY --from=commons /sbin/tini /sbin/
COPY --from=commons /home /home

# When Bash is invoked via `sh` it behaves like the old Bourne Shell and sources a file that is given in `ENV`
# When Bash is invoked as non-interactive (like `bash -c command`) it sources a file that is given in `BASH_ENV`
ENV TMPDIR=/tmp TMP=/tmp HOME=/home ENV=/home/.bashrc BASH_ENV=/home/.bashrc

# Install rsyslog like the "official" rsyslog image: https://github.com/rsyslog/rsyslog-docker/blob/master/appliance/alpine/Dockerfile
# As the alpine packages do not have 'rsyslog-omrelp'
COPY rsyslog@lists.adiscon.com-5a55e598.rsa.pub /etc/apk/keys/rsyslog@lists.adiscon.com-5a55e598.rsa.pub
RUN echo "http://alpine.rsyslog.com/3.7/stable" >> /etc/apk/repositories \
	&& apk --no-cache update  \
	&& apk add --no-cache \
	   rsyslog \
	   rsyslog-omrelp

ENV SYSLOG_TCP_HOST=syslog.lagoon.svc \
    SYSLOG_TCP_PORT=5140 \
    SYSLOG_STDOUT=FALSE

COPY rsyslog.conf /etc/rsyslog.conf
COPY stdout.conf /etc/rsyslog.d/stdout.conf.disabled
COPY entrypoint.sh /lagoon/entrypoints/99-rsyslog-conf.sh

RUN fix-permissions /etc/rsyslog.conf \
    && fix-permissions /etc/rsyslog.d

ENTRYPOINT ["/sbin/tini", "--", "/lagoon/entrypoints.sh"]
CMD ["rsyslogd", "-i", "/tmp/rsyslogd.pid", "-n"]
