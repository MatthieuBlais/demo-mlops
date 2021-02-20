#!/bin/bash

# Infering branch name
export BRANCH_NAME=`git symbolic-ref HEAD --short 2>/dev/null`
if [ "$BRANCH_NAME" == "" ] ; then
  BRANCH_NAME=`git branch -a --contains HEAD | sed -n 2p | awk '{ printf $1 }'`
  export BRANCH_NAME=${BRANCH_NAME#remotes/origin/}
fi
