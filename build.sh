#!/bin/bash

uv sync

mkdir -p flash-attention/dist
mkdir -p flash-attention/hopper/dist

if [[ "$1" == "--flash-attn3" ]]; then
    (cd flash-attention/hopper; MAX_JOBS=16 uv run python setup.py bdist_wheel)
else
    (cd flash-attention; MAX_JOBS=16 uv run python setup.py bdist_wheel)
fi
