#!/bin/bash

# Checking if the repository follows the structure convention
if [ ! -d "components" ]; then
    echo "No components, stopping build"
    exit 1
fi

export BRANCH_NAME=`git symbolic-ref HEAD --short 2>/dev/null`
if [ "$BRANCH_NAME" == "" ] ; then
  BRANCH_NAME=`git branch -a --contains HEAD | sed -n 2p | awk '{ printf $1 }'`
  export BRANCH_NAME=${BRANCH_NAME#remotes/origin/}
fi

echo "REPO_NAME: $PROJECT_NAME"
echo "BRANCH_NAME: $BRANCH_NAME"

mkdir _artifacts/$BRANCH_NAME && touch _artifacts/$BRANCH_NAME/images.txt

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
        echo "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME/$image_name:$BRANCH_NAME-$CODEBUILD_BUILD_NUMBER" >> ../../_artifacts/$BRANCH_NAME/images.txt
    else
        echo "No Dockerfile for component $folder. Skipping"
    fi
    cd ..
  fi
done