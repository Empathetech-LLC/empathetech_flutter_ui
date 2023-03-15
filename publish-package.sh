#!/bin/bash

set -e

# Only run on main
BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ $BRANCH != "main" ]]; then
  echo "ERROR: This script can only be run on the main branch"
  exit 1
fi

# Make sure there's an existing git tag && release for the current version
CURR_VERSION=$(cat APP_VERSION)

# Tag check
if ! git rev-parse --quiet --verify "refs/tags/$CURR_VERSION" > /dev/null 2>&1; then
  echo "ERROR: there's no git tag matching version $CURR_VERSION"
  exit 1
fi

# Release check
if ! git rev-parse --quiet --verify "refs/tags/$CURR_VERSION" > /dev/null 2>&1; then
  echo "ERROR: there's no git release matching version $CURR_VERSION"
  exit 1
fi

# Publish

dart pub publish