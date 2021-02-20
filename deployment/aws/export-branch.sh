#!/bin/sh

# Infering branch name
export BRANCH_NAME="$(git symbolic-ref HEAD --short 2>/dev/null)"
if [ "$BRANCH_NAME" = "" ] ; then
  export BRANCH_NAME="$(git rev-parse HEAD | xargs git name-rev | cut -d' ' -f2 | sed 's/remotes\/origin\///g')";
fi
