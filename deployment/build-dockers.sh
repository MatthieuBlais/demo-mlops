#!/bin/bash

# Checking if the repository follows the structure convention
if [ ! -d "components" ]; then
    echo "No components, stopping build"
    exit 1
fi

cd components/

echo "Project_ID: $PROJECT_ID"
echo "BRANCH_NAME: $BRANCH_NAME"
echo "SHORT_SHA: $SHORT_SHA"

# Looping through all components and build if there is a Dockerfile
for folder in */; do
  if [ -d "$folder" ]; then
    cd $folder
    ls
    if [[ -f "Dockerfile" ]]; then
        echo "Building Docker image for component $folder..."
        image_name="${folder%?}"
        echo "sample gcr.io/$PROJECT_ID/demo-mlops/$image_name:$BRANCH_NAME-$SHORT_SHA"
        docker build -t gcr.io/$PROJECT_ID/demo-mlops/$image_name:$BRANCH_NAME-$SHORT_SHA -t gcr.io/$PROJECT_ID/demo-mlops/$image_name:$BRANCH_NAME-latest .
        docker push gcr.io/$PROJECT_ID/demo-mlops/$image_name
    else
        echo "No Dockerfile for component $folder. Skipping"
    fi
    cd ..
  fi
done