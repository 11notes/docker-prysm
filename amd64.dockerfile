# :: Header
	FROM ubuntu:22.04
    ENV checkout=v3.1.2

# :: Run
	USER root

	# :: prepare
        RUN set -ex; \
            mkdir -p /prysm; \
            mkdir -p /prysm/etc; \
            mkdir -p /prysm/var;

        ADD https://github.com/prysmaticlabs/prysm/releases/download/${checkout}/beacon-chain-${checkout}-linux-amd64 /usr/local/bin/prysm

		RUN set -ex; \
            apt-get update -y; \
            apt-get -y upgrade -y; \
            apt-get install -y --no-install-recommends \
                libssl-dev \
                curl \
                ca-certificates \
                tar; \
            apt-get clean; \
            rm -rf /var/lib/apt/lists/*; \
            chmod +x /usr/local/bin/prysm;

		RUN set -ex; \
            addgroup --gid 1000 prysm; \
            useradd -d /prysm -g 1000 -s /sbin/nologin -u 1000 prysm;

    # :: copy root filesystem changes
        COPY ./rootfs /

    # :: docker -u 1000:1000 (no root initiative)
        RUN set -ex; \
            chown -R prysm:prysm \
				/prysm

# :: Volumes
	VOLUME ["/prysm/var"]

# :: Monitor
    RUN set -ex; chmod +x /usr/local/bin/healthcheck.sh
    HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
	RUN set -ex; chmod +x /usr/local/bin/entrypoint.sh
	USER prysm
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]