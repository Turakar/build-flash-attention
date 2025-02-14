#!/bin/bash

uv sync

(cd flash-attention; MAX_JOBS=16 uv run python setup.py bdist_wheel)

(cd flash-attention/hopper; MAX_JOBS=16 uv run python setup.py bdist_wheel)
