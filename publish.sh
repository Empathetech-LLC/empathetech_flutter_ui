#!/bin/bash

set -e

# Only run on main
BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ $BRANCH != "main" ]]; then
  echo "ERROR: This script can only be run on the main branch"
  exit 1
fi

# Fail if a tag already exists
if git describe --exact-match HEAD >/dev/null 2>&1; then
  echo "ERROR: Current commit already has a git tag"
  exit 1
fi

# Gather release information
CURR_VERSION=$(cat APP_VERSION)

VERSION_REGEX="## \[[0-9]+\.[0-9]+\.[0-9]+\] \- [0-9]+\-[0-9]+\-[0-9]+"
CURR_VERSION_REGEX="## \[$CURR_VERSION\] \- [0-9]+\-[0-9]+\-[0-9]+"

# Find the line numbers for all version bumps in the CHANGELOG
LINE_NUMS_STR=$(grep -nE "$VERSION_REGEX" CHANGELOG.md | cut -d':' -f1)
LINE_NUMS=($LINE_NUMS_STR)

# Find the line number for the current version bump
CHOSEN_LINE=$(grep -nE "$CURR_VERSION_REGEX" CHANGELOG.md | cut -d':' -f1)

# Find the position of the current version in the lineage
index=-1
for i in "${!LINE_NUMS[@]}";
do
  if [[ "${LINE_NUMS[$i]}" = "${CHOSEN_LINE}" ]];
  then
    index=$i
    break
  fi
done

# Return the appropriate snippet based on position
notes=""
len=${#LINE_NUMS[@]}
final=$((len - 1))

if [ $index -lt $final ]; then
  pal=$((index + 1))
  notes=$(sed -n "$(( ${LINE_NUMS[index]} + 1 )),$(( ${LINE_NUMS[pal]} - 1 ))p" CHANGELOG.md)
else
  notes=$(sed -n "$(( ${LINE_NUMS[index]} + 1 )),\$p" CHANGELOG.md)
fi

gh release create "$version" -t "$version" -n "$notes"