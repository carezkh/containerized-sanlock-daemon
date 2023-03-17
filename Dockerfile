FROM alpine:3.17

RUN apk add tini s6-overlay
RUN apk add sanlock --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

COPY s6-svscan-finish.sh /etc/services.d/.svscan/finish

COPY wdmd-run.sh /etc/services.d/wdmd/run
COPY sanlock-run.sh /etc/services.d/sanlock/run
RUN chmod -R +x /etc/services.d/

ENTRYPOINT ["tini", "-s", "-g", "--", "/bin/s6-svscan", "-t0", "/etc/services.d"]
