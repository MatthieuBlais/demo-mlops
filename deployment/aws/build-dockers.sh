#!/bin/bash

# Checking if the repository follows the structure convention
if [ ! -d "components" ]; then
    echo "No components, stopping build"
    exit 1
fi

echo "REPO_NAME: $PROJECT_NAME"
echo "BRANCH_NAME: $BRANCH_NAME"

# Folder has been created by pytest script
touch _artifacts/images.txt

cd components/

# Looping through all components and build if there is a Dockerfile
for folder in */; do
  if [ -d "$folder" ]; then
    cd $folder
    ls
    if [[ -f "Dockerfile" ]]; then
        echo "Building Docker image for component $folder..."
        image_name="${folder%?}"
        aws ecr describe-repositories --repository-names $PROJECT_NAME/$image_name || aws ecr create-repository --repository-name $PROJECT_NAME/$image_name
        docker build -t $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME/$image_name:$BRANCH_NAME-$CODEBUILD_BUILD_NUMBER -t $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME/$image_name:$BRANCH_NAME-latest .
        docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME/$image_name
        echo "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME/$image_name:$BRANCH_NAME-$CODEBUILD_BUILD_NUMBER" >> ../../_artifacts/images.txt
    else
        echo "No Dockerfile for component $folder. Skipping"
    fi
    cd ..
  fi
done