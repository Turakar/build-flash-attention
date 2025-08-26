#!/bin/bash

set -e

uv sync
uv run python -c 'import torch; print(f"torch version: {torch.__version__}\ntorch cuda version: {torch.version.cuda}")'

export FLASH_ATTENTION_FORCE_BUILD=TRUE

mkdir -p flash-attention/dist
mkdir -p flash-attention/hopper/dist

if [[ "$1" == "--flash-attn-3" ]]; then
    rm -rf flash-attention/hopper/build/*
    # hopper compilation is extremely memory hungry, up to 22 GB per job (1 job = 1 thread)
    (cd flash-attention/hopper; uv run python setup.py sdist; MAX_JOBS=4 uv run python setup.py bdist_wheel)
else
    rm -rf flash-attention/build/*
    # effectively 16 threads, 8 jobs * 2 GPU architectures
    (cd flash-attention; uv run python setup.py sdist; MAX_JOBS=8 FLASH_ATTN_CUDA_ARCHS="80;90" uv run python setup.py bdist_wheel)
fi
