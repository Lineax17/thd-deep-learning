# syntax=docker/dockerfile:1.7

ARG TF_IMAGE=rocm/tensorflow:rocm7.2-py3.12-tf2.20-dev
FROM ${TF_IMAGE}

WORKDIR /workspace/thd-deep-learning

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    TF_FORCE_GPU_ALLOW_GROWTH=true \
    TF_CPP_MIN_LOG_LEVEL=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml ./
RUN python -m pip install --no-cache-dir --upgrade pip \
    && python - <<'PY'
from pathlib import Path
import subprocess
import sys
import tomllib

toml = tomllib.loads(Path('pyproject.toml').read_text())
deps = [
    dep for dep in toml['project']['dependencies']
    if not dep.lower().startswith('tensorflow')
]
if deps:
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '--no-cache-dir', *deps])
PY

COPY src ./src

ENV PYTHONPATH=/workspace/thd-deep-learning/src \
    TF_FORCE_GPU_ALLOW_GROWTH=true \
    TF_CPP_MIN_LOG_LEVEL=1

CMD ["python", "src/transferlearning/multilabel_classification/training_freezed.py"]

