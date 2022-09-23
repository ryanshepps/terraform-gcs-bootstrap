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

create_service_account() {
  local project_name="${1}"
  local service_account_name="${2}"

  local service_account_name="terraform"

  gcloud iam service-accounts create $service_account_name \
    --description="Neccessary for Terraform to perform actions on this project." \
    --display-name=$service_account_name
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
  create_service_account $project_name $service_account_name
}

main "$@"