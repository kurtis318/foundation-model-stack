#!/bin/bash
# -*- coding: utf-8 -*-
# Copyright IBM Corp.
# SPDX-License-Identifier: Apache-2.0

export FLEX_RESPONSE_WORKER_MAX_PENDING_REQUESTS=32768

# Graph Break Capture and Dynamo Tracing
export TORCH_LOGS="dynamo,graph_breaks"

# Sengraph Capture
export TORCH_SENDNN_LOG="DEBUG"
# torch_sendnn dumps of the FX graphs from PyTorch
export DEE_DUMP_GRAPHS=bamba9B
export DTCOMPILER_KEEP_EXPORT=1

TIMESTAMP=$(date +%Y_%m_%d_%H_%M)
MODEL_NAME="qwen3/Qwen3-1.7B"
MODEL_PATH="/home/kurtis/Projects/aiu/models/Qwen3-1.7B/"
TOKENIZER=${MODEL_PATH}
OUT_DIR="/home/kurtis/Projects/aiu/models/output/${MODEL_NAME}/${TIMESTAMP}"
mkdir -p "${OUT_DIR}"
OUT_FILE="${OUT_DIR}/run_output.txt"

export DTCOMPILER_EXPORT_DIR="${OUT_DIR}/export"
#    --max_new_tokens=8 
#   --no_early_termination 
#   --batch_size=1 \
time PYTHONUNBUFFERED="1" TORCH_LOGS="dynamo,graph_breaks" python3 ../../scripts/inference.py \
    --architecture=qwen3 \
    --variant=1.7b \
    --model_path="${MODEL_PATH}" \
    --model_source=hf \
    --tokenizer="${TOKENIZER}" \
    --min_pad_length=64 \
    --device_type=cpu \
    --compile \
    --default_dtype=fp16 \
    --unfuse_weights \
    > "${OUT_DIR}/run_output.txt" 2>&1
    RC=$?
    echo "Output is in file '${OUT_FILE}'"
    echo "RC=${RC}"
