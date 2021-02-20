#!/bin/bash

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
    pipenv run coverage json --pretty-print -o ../../_artifacts/${folder%?}-coverage.json
    cd ..
  fi
done