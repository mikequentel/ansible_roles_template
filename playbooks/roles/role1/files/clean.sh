#!/bin/bash

if [ -z "${OUTPUT_DIR}" ]; then
  echo "ERROR: missing environment variables"
  exit 1
fi

if [ -d ${OUTPUT_DIR} ]; then
  echo
  echo "cleaning ${OUTPUT_DIR}"
  rm -fr ${OUTPUT_DIR}/*
  echo "RESULTS:"
  ls -hal ${OUTPUT_DIR}/
else
  echo "${OUTPUT_DIR} does not exist"
fi
