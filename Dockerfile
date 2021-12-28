# TODO: switch to alpine base image when sanlock* is supported in repositories.
FROM fedora:34

ENV TINI_VERSION v0.19.0
RUN set -euxo pipefail; \
    case $(arch) in x86_64) arch=amd64;; aarch64) arch=arm64;; esac; \
    curl -SL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-$arch -o /tini
RUN chmod +x /tini

RUN dnf install -y sanlock sanlock-lib && dnf clean all

COPY ./start-all.sh /start-all.sh
RUN chmod +x /start-all.sh

ENTRYPOINT ["/tini", "-s", "-g", "--", "/start-all.sh"]
