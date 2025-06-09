#!/bin/bash

# Run all pytests in currect directory 
#
LOGF="/tmp/_run.text"

function banner_msg {
  local MSG=''
  local LEN_P1="${#1}"
  local LEN_P2="${#2}"
  local LEN_P3="${#3}"
  local DASH_CNT=${LEN_P1}
  if (( LEN_P2 > DASH_CNT )); then
     DASH_CNT=${LEN_P1}
  fi
  if (( LEN_P3 > DASH_CNT)); then
     DASH_CNT=${LEN_P3}
  fi
  (( DASH_CNT=DASH_CNT+5 ))
  BLINE="#$(  printf "%${DASH_CNT}s" |tr " " "-")"
  # MSG="\n${BLINE}\n#  ${1}\n#    ${2}\n#      ${3}\n${BLINE}"
  MSG="\n${BLINE}\n#  ${1}\n${BLINE}"
  echo -e "${MSG}"
  return
} # banner_msg()

function runpyt() {
FN=$1
banner_msg " Running pytest ${FN}"
time pytest "${FN}"  | tee -a "${LOGF}"
}  # runpyt()

banner_msg "Start time: $(date)"
runpyt test_bamba.py
runpyt test_getmodel_datatype.py
runpyt test_getmodel_fusedweights.py
runpyt test_gpt_bigcode.py
runpyt test_granite.py
runpyt test_llama.py
runpyt test_mistral.py
runpyt test_mixtral.py
runpyt test_models.py
runpyt test_roberta.py
banner_msg "End time: $(date)"

