#!/bin/bash

set -e

uv sync
uv run python -c 'import torch; print(f"torch version: {torch.__version__}\ntorch cuda version: {torch.version.cuda}")'

export FLASH_ATTENTION_FORCE_BUILD=TRUE

mkdir -p flash-attention/dist
mkdir -p flash-attention/hopper/dist

if [[ "$1" == "--flash-attn3" ]]; then
    rm -rf flash-attention/hopper/build/*
    (cd flash-attention/hopper; uv run python setup.py sdist; MAX_JOBS=8 uv run python setup.py bdist_wheel; )
else
    rm -rf flash-attention/build/*
    (cd flash-attention; uv run python setup.py sdist; MAX_JOBS=8 FLASH_ATTN_CUDA_ARCHS="80;90" uv run python setup.py bdist_wheel)
fi
