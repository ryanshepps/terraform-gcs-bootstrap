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

set_project() {
  local project_name="${1}"

  verify_project_exists $project_name
  gcloud config set project $project_name
}

create_cloud_bucket() {
  local bucket_name="terraform-tfstate-$(hexdump -vn8 -e'4/4 "%08x" 1 "\n"' /dev/urandom)"
  gcloud storage buckets create gs://$bucket_name
}

main() {
  if ! verify_params $@
  then
    echo_usage
    exit 1
  fi 

  local project_name="${1}"

  authenticate
  set_project $project_name
  create_cloud_bucket
}

main "$@"