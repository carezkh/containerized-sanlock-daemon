# TODO: switch to alpine base image when sanlock* is supported in repositories.
# see also: https://gitlab.alpinelinux.org/alpine/aports/-/issues/13282
FROM fedora:34

RUN dnf install -y tini sanlock sanlock-lib && dnf clean all

ENV S6_OVERLAY_VERSION v2.2.0.1
RUN set -euxo pipefail; \
    case $(arch) in x86_64) arch=amd64;; aarch64) arch=aarch64;; esac; \
    curl -SL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-$arch-installer -o /tmp/s6-overlay-installer
RUN chmod +x /tmp/s6-overlay-installer && /tmp/s6-overlay-installer /

COPY s6-svscan-finish.sh /etc/services.d/.svscan/finish

COPY wdmd-run.sh /etc/services.d/wdmd/run
COPY sanlock-run.sh /etc/services.d/sanlock/run
RUN chmod -R +x /etc/services.d/

ENTRYPOINT ["tini", "-s", "-g", "--", "/bin/s6-svscan", "-t0", "/etc/services.d"]
