#!/bin/bash

set -eu

if [ $# -ne 1 ]; then
  echo "Usage: $0 {semantic_suma|kiss_slam|spark_fast_lio|semantic_dsp_map|lio_sam}"
  exit 1
fi

VARIANT=$1
IMAGE=benchmark_"$VARIANT"
NAME="$IMAGE"
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

if ! [ -d "src" ]; then
  echo "Error: directory \`src\` not found. Please run this script from the root of the slam_benchmark repository."
  exit 1
fi

if ! [ -f "${XAUTH}" ]; then
  touch "${XAUTH}"
  xauth nlist "${DISPLAY}" | sed -e 's/^..../ffff/' | xauth -f "${XAUTH}" nmerge -
  chmod 644 "${XAUTH}"
fi

if [ "$(docker ps -aq -f status=exited -f name="${NAME}")" ]; then
  docker start "${NAME}"
  exec docker exec -it "${NAME}" bash
elif [ "$(docker ps -aq -f status=running -f name="${NAME}")" ]; then
  exec docker exec -it "${NAME}" bash
else
  exec docker run \
    -it \
    --env=DISPLAY="${DISPLAY}"  \
    --env=QT_X11_NO_MITSHM=1 \
    --env=XDG_RUNTIME_DIR=/tmp \
    --env=XAUTHORITY="${XAUTH}" \
    --volume="${XAUTH}":"${XAUTH}" \
    --volume="${XSOCK}":"${XSOCK}" \
    --volume "${PWD}"/src:/root/ws/src \
    --volume "${PWD}"/rosbags:/root/ws/rosbags \
    --network=host \
    --name="${NAME}" \
    "${IMAGE}" \
    bash
fi
