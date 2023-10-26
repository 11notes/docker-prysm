# :: Header
  FROM ubuntu:22.04
  ENV APP_VERSION="4.1.1"
  ENV APP_ROOT="/prysm"

# :: Run
  USER root

  # :: prepare
    RUN set -ex; \
      mkdir -p ${APP_ROOT}; \
      mkdir -p ${APP_ROOT}/etc; \
      mkdir -p ${APP_ROOT}/var;

    ADD https://github.com/prysmaticlabs/prysm/releases/download/v${APP_VERSION}/beacon-chain-v${APP_VERSION}-linux-amd64 /usr/local/bin/prysm-no-adx
    ADD https://github.com/prysmaticlabs/prysm/releases/download/v${APP_VERSION}/beacon-chain-v${APP_VERSION}-modern-linux-amd64 /usr/local/bin/prysm-adx

    RUN set -ex; \
      apt-get update -y; \
      apt-get upgrade -y; \
      apt-get install -y --no-install-recommends \
        libssl-dev \
        curl \
        ca-certificates; \
        apt-get clean; \
      rm -rf /var/lib/apt/lists/*; \
      chmod +x -R /usr/local/bin;

    RUN set -ex; \
      addgroup --gid 1000 docker; \
      useradd -d ${APP_ROOT} -g 1000 -s /sbin/nologin -u 1000 docker;

  # :: copy root filesystem changes
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin

  # :: docker -u 1000:1000 (no root initiative)
    RUN set -ex; \
      chown -R 1000:1000 \
        ${APP_ROOT} \
        /usr/local/bin

# :: Volumes
  VOLUME ["${APP_ROOT}/var"]

# :: Monitor
  HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]