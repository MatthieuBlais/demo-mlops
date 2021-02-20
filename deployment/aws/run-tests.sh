#!/bin/bash

# Infering branch name
export BRANCH_NAME=`git symbolic-ref HEAD --short 2>/dev/null`
if [ "$BRANCH_NAME" == "" ] ; then
  BRANCH_NAME=`git branch -a --contains HEAD | sed -n 2p | awk '{ printf $1 }'`
  export BRANCH_NAME=${BRANCH_NAME#remotes/origin/}
fi
mkdir _artifacts/$BRANCH_NAME

# Checking if the repository follows the structure convention
if [ ! -d "components" ]; then
    echo "No components, stopping build"
    exit 1
fi

cd components/

# Looping through all components and execute pytest
for folder in */; do
  echo $folder
  if [ -d "$folder" ]; then
    echo "Testing component $folder..."
    cd $folder
    # Install component requirements
    pipenv install pytest pytest-cov --dev
    pipenv install -r requirements.txt
    # Running Pytest
    pipenv run python -m pytest --junitxml=../../_reports/${folder%?}-coverage.xml --cov app/
    # Saving the coverage report in the artifact folder
    pipenv run coverage json --pretty-print -o ../../_artifacts/$BRANCH_NAME/${folder%?}-coverage.json
    cd ..
  fi
done