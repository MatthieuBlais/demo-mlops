#!/bin/bash

# Checking if the repository follows the structure convention
if [ ! -d "components" ]; then
    echo "No components, stopping build"
    exit 1
fi

# We save the list of docker images as artifact
mkdir _artifacts
touch _artifacts/images.txt

cd components/

echo "PROJECT_ID: $PROJECT_ID"
echo "REPO_NAME: $REPO_NAME"
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
        docker build -t gcr.io/$PROJECT_ID/$REPO_NAME/$image_name:$BRANCH_NAME-$SHORT_SHA -t gcr.io/$PROJECT_ID/$REPO_NAME/$image_name:$BRANCH_NAME-latest .
        docker push gcr.io/$PROJECT_ID/$REPO_NAME/$image_name
        echo "gcr.io/$PROJECT_ID/$REPO_NAME/$image_name:$BRANCH_NAME-$SHORT_SHA" >> _artifacts/images.txt
    else
        echo "No Dockerfile for component $folder. Skipping"
    fi
    cd ..
  fi
done