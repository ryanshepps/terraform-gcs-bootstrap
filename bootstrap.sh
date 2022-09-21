#!/bin/bash

set -e

verify_params() {
  if [ $# != 1 ]
  then 
    return 1
  fi

  return 0
}

echo_usage() {
  echo "Usage: $0 PROJECT_ID"
}

authenticate() {
  echo "Log into an account that has storage.buckets.list permissions on your Google Cloud Project."
  gcloud auth login
}

verify_project_exists() {
  local project_name="${1}"
  gcloud projects describe $project_name
}

main() {
  if ! verify_params $@
  then
    echo_usage
    exit 1
  fi 

  local project_name="${1}"

  authenticate
  verify_project_exists $project_name
}

main "$@"