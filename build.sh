#!/bin/bash

set -e

uv sync
uv run python -c 'import torch; print(f"torch version: {torch.__version__}\ntorch cuda version: {torch.version.cuda}")'

export FLASH_ATTENTION_FORCE_BUILD=TRUE
export FLASH_ATTN_CUDA_ARCHS="80;90"

mkdir -p flash-attention/dist
rm -rf flash-attention/build/*
mkdir -p flash-attention/hopper/dist
rm -rf flash-attention/hopper/build/*

if [[ "$1" == "--flash-attn3" ]]; then
    (cd flash-attention/hopper; MAX_JOBS=8 uv run python setup.py bdist_wheel; uv run python setup.py sdist)
else
    (cd flash-attention; MAX_JOBS=8 uv run python setup.py bdist_wheel; uv run python setup.py sdist)
fi
