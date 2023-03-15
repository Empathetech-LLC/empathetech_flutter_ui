#!/bin/bash

set -e

# Only run on main
BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ $BRANCH != "main" ]]; then
  echo "ERROR: This script can only be run on the main branch"
  exit 1
fi

# Publish

dart pub publish