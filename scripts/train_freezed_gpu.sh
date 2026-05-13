#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_NAME="thd-deep-learning:freezed"
TF_IMAGE="${TF_IMAGE:-rocm/tensorflow:rocm7.2-py3.12-tf2.20-dev}"

mkdir -p "$ROOT_DIR/models"

docker build \
  -t "$IMAGE_NAME" \
  --build-arg TF_IMAGE="$TF_IMAGE" \
  "$ROOT_DIR"

docker run --rm -it \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add video \
  --ipc=host \
  --mount type=bind,src="$ROOT_DIR/data",dst=/workspace/thd-deep-learning/data,readonly \
  --mount type=bind,src="$ROOT_DIR/models",dst=/workspace/thd-deep-learning/models \
  -e MODEL_OUTPUT_DIR=/workspace/thd-deep-learning/models \
  "$IMAGE_NAME"

