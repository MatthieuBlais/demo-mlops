#!/bin/bash

# Checking if the repository follows the structure convention
if [ ! -d "components" ]; then
    echo "No components, stopping build"
    exit 1
fi

cd components/

# Looping through all components and build if there is a Dockerfile
for folder in */; do
  if [ -d "$folder" ]; then
    cd $folder
    if [[ -f "Dockerfile" ]]; then
        echo "Building Docker image for component $folder..."
        image_name="${folder%?}"
        docker build -t gcr.io/$PROJECT_ID/demo-mlops/$image_name:$BRANCH_NAME-$SHORT_SHA -t gcr.io/$PROJECT_ID/demo-mlops/$image_name:$BRANCH_NAME-latest .
        docker push gcr.io/$PROJECT_ID/demo-mlops/$image_name
    else
        echo "No Dockerfile for component $folder. Skipping"
    fi
    cd ..
  fi
done