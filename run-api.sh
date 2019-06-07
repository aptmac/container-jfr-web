#!/bin/sh

set -x

function stop_docker() {
  docker kill container-jmc
}

stop_docker

set -e

trap stop_docker EXIT

docker run \
  -d --rm \
  --name container-jmc \
  --hostname jmx-client \
  -p 9090:9090 -p 9091:9091 -p 80:8080 \
  -e CONTAINER_DOWNLOAD_HOST=localhost \
  -e CONTAINER_DOWNLOAD_PORT=8080 \
  andrewazores/container-jmx-client

node mockapi.server.js
