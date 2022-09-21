#!/bin/bash

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

main() {
  if ! verify_params $@
  then
    echo_usage
    exit 1
  fi 
}

main "$@"