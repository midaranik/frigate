#!/bin/bash
set -euo pipefail

docker run -d \
  --name frigate \
  --restart=unless-stopped \
  --stop-timeout 30 \
  --mount type=tmpfs,target=/tmp/cache,tmpfs-size=1000000000 \
  --device /dev/bus/usb:/dev/bus/usb \
  --device /dev/dri/renderD128 \
  --device /dev/hailo0 \
  --shm-size=512m \
  --privileged \
  -v /frigate/storage:/media/frigate \
  -v /frigate/config:/config \
  -v /etc/localtime:/etc/localtime:ro \
  -v /frigate/cert:/etc/letsencrypt/live/frigate:ro \
  -e FRIGATE_RTSP_PASSWORD='password' \
  -p 443:8971 \
  -p 8554:8554 \
  -p 8555:8555/tcp \
  -p 8555:8555/udp \
  frigate
