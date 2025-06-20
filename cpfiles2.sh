#!/bin/bash

# Copy files from repo to another with same directory structure
# Added feature: checks for target directory existance
#                if it does not exist then it is cretaed
#                then copy is done. This provides a way to
#                create a directory of only changes. Good
#                for use with source and target being in
#                different github branches.

SRC_DIR=""
TAR_DIR=""
FULL_TAR_DIR=""

function do_cpy() {
  local SRCF=$1
  if [[ ! -f "${SRC_DIR}/${SRCF}" ]]; then
    echo "ERROR: SOURCE file not found: '${BASE_SRC}/${SRCF}'"
    return
  fi
  if [[ -f "${TAR_DIR}/${SRCF}" ]]; then
    echo "ERROR: TARGET file exists: '${TAR_DIR}/${SRCF}'"
    return
  fi
  FULL_TAR_DIR_PATH=$( readlink -f "${TAR_DIR}" )
  FULL_TAR_FILE_DIR=$( dirname "${FULL_TAR_DIR_PATH}/${SRCF}" )
  echo "#------------------------------------------------------------------------------"
  echo "<SRCF=${SRCF}>"
  echo -e "<FULL_TAR_DIR_PATH=${FULL_TAR_DIR_PATH}>\n<FULL_TAR_FILE_DIR=${FULL_TAR_FILE_DIR}>"
  if [[ ! -d "${FULL_TAR_FILE_DIR}" ]]; then
    echo "INFO: creating full target directory '${FULL_TAR_FILE_DIR}'}"
    mkdir -p "${FULL_TAR_FILE_DIR}" 
  fi
  echo "COPYING: '${SRC_DIR}/${SRCF}' --> '${TAR_DIR}/${SRCF}'"
  cp "${SRC_DIR}/${SRCF}" "${TAR_DIR}/${SRCF}"
  RC=$?
  if (( RC != 0 )); then
    echo "ERROR: cp command failed rc=${RC}"
  fi
}  # do_copy()

function check_parms() {
  # echo "<SRC_DIR=${SRC_DIR}> <TAR_DIR=${TAR_DIR}>"
  if [[ -z "${SRC_DIR}" ]]; then
    echo "ERROR: SOURCE directory is missing"
    exit 1
  fi
  if [[ -z "${TAR_DIR}" ]]; then
    echo "ERROR: TARGET directory is missing"
    exit 2
  fi

  if [[ ! -d "${SRC_DIR}" ]]; then
    echo "ERROR: SOURCE directory not found: '${SRC_DIR}'"
    exit 3
  fi

  # Don't need this check anymore
  # if [[ ! -d "${TAR_DIR}" ]]; then
  #   echo "ERROR: TARGET directory not found: '${TAR_DIR}'"
  #   exit 4
  # fi

  FULL_SRC_DIR=$(readlink -f "${SRC_DIR}")
  FULL_TAR_DIR=$(readlink -f "${TAR_DIR}")
  if [[ "${FULL_SRC_DIR}" == "${FULL_TAR_DIR}" ]]; then
    echo "ERROR: SOURCE and TARGET directories cannot be the same '${FULL_SRC_DIR}'"
    exit 5
  fi
}  # check_parms()

#------------------------------
# script execition begins here
#------------------------------
SRC_DIR="${1}"
TAR_DIR="${2}"
echo "<SRC_DIR=${SRC_DIR}> <TAR_DIR=${TAR_DIR}>"

check_parms
# do_cpy "fms/model_load.py"
do_cpy "fms/models/__init__.py"
do_cpy "fms/models/hf/utils.py"
do_cpy "fms/models/qwen.py"
do_cpy "fms/modules/attention.py"
# do_copy "fms/testing/_internal/model_test_suite.py"
# do_cpy "scripts/inference.py"
# do_cpy "scripts/kwr_inference.py"
# do_cpy "setup.py"
do_cpy "tests/models/cpufmsinf.py"
do_cpy "tests/models/qwenhfsamplecpu.py"
do_cpy "tests/models/qwenmodelload.py"
# do_cpy "tests/models/run.sh"
do_cpy "tests/models/runqweninfcpu.sh"
do_cpy "tests/models/test_qwen.py"
# do_cpy "tests/models/test_qwen_inference.sh"
# do_cpy "tests/resources/expectations/models.test_qwen.Test_Qwen.test_model_weight_keys"

