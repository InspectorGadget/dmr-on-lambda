#!/bin/bash

AWS_REGION=ap-southeast-1
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REPO=model-runner-lambda

aws ecr create-repository --repository-name $REPO --region $AWS_REGION || true
aws ecr get-login-password --region $AWS_REGION \
| docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build for your chosen arch; x86_64 shown here
docker build -t $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO:latest . --provenance=false --platform linux/arm64 
docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO:latest

ROLE_ARN=arn:aws:iam::$ACCOUNT_ID:role/basic-lambda
aws lambda create-function \
  --function-name model-runner-lambda \
  --package-type Image \
  --code ImageUri=$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO:latest \
  --role $ROLE_ARN \
  --architectures arm64 \
  --memory-size 4096 \
  --timeout 900

aws lambda update-function-code \
  --function-name model-runner-lambda \
  --image-uri $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO:latest