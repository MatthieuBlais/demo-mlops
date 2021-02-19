#!/bin/bash

# Checking if the repository follows the structure convention
if [ ! -d "components" ]; then
    echo "No components, stopping build"
    exit 1
fi

# Installing env segregation
pip install pipenv

# We save the list of docker images as artifact
mkdir _artifacts

cd components/

# Looping through all components and execute pytest
for folder in */; do
  echo $folder
  if [ -d "$folder" ]; then
    echo "Testing component $folder..."
    cd $folder
    pipenv install pytest pytest-cov --dev
    pipenv install -r requirements.txt
    pipenv run python -m pytest --cov app/

    # Saving the coverage report in the artifact folder
    pipenv run coverage json --pretty-print -o ../../_artifacts/${folder%?}-coverage.json

    cd ..
  fi
done