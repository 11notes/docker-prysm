# Ubuntu :: Prysm
![size](https://img.shields.io/docker/image-size/11notes/prysm/4.1.1?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/prysm?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/prysm?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-prysm?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-prysm?color=c91cb8)

Run a Prysm node based on Ubuntu. Big, heavy, mostly secure and a bit slow 🍟

## Volumes
* **/prysm/var** - Directory of beacon chain

## Run
```shell
  docker run --name prysm \
    -v .../var:/prysm/var \
    -v .../jwtsecret:/prysm/etc/jwtsecret \
    -d 11notes/prysm:[tag]
```

```shell
  docker run --name prysm \
    -v .../var:/prysm/var \
    -v .../jwtsecret:/prysm/etc/jwtsecret \
    -d 11notes/prysm:[tag] \
      prysm \
      --accept-terms-of-use \
      --datadir "/prysm/var" \
      --restore-target-dir "/prysm/var" \
      --execution-endpoint http://localhost:8551 \
      --jwt-secret /prysm/etc/jwtsecret \
      --p2p-local-ip 0.0.0.0 \
      --monitoring-host 0.0.0.0 \
      --p2p-host-ip 13.224.103.127 \
      --grpc-gateway-host 0.0.0.0 \
      --grpc-gateway-corsdomain '*' \
      --checkpoint-sync-url=https://checkpoint.eth.web3.anon.global \
      --genesis-beacon-api-url=https://checkpoint.eth.web3.anon.global
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /prysm | home directory of user docker |

## Parent image
* [ubuntu:22.04](https://git.launchpad.net/cloud-images/+oci/ubuntu-base/tree/oci/index.json?h=refs/tags/dist-jammy-amd64-20231004-b438933c&id=b438933cb5f916fc82c2422834bcd6bf6161f3e9)

## Built with and thanks to
* [Prysm](https://github.com/prysmaticlabs/prysm)
* [Ubuntu](https://hub.docker.com/_/ubuntu)

## Tips
* Increase cache as much as you can (64GB+ recommended)
* Don't kill container, stop gracefully with enough time to sync RAM to disk!
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)