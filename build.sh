#!/bin/bash

set -e

uv sync

export FLASH_ATTENTION_FORCE_BUILD=TRUE
export FLASH_ATTN_CUDA_ARCHS="80;90"

mkdir -p flash-attention/dist
mkdir -p flash-attention/hopper/dist

if [[ "$1" == "--flash-attn3" ]]; then
    (cd flash-attention/hopper; MAX_JOBS=8 uv run python setup.py bdist_wheel; uv run python setup.py sdist)
else
    (cd flash-attention; MAX_JOBS=8 uv run python setup.py bdist_wheel; uv run python setup.py sdist)
fi
