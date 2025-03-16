#!/bin/bash

# Set your Docker Hub username
DOCKER_USERNAME="anarallc"
# Set the image name
IMAGE_NAME="chatwoot"
# Set the image tag
IMAGE_TAG="latest"

# Full image name
FULL_IMAGE_NAME="$DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG"

echo "Building Docker image using our custom Dockerfile: $FULL_IMAGE_NAME"
# Use our custom Dockerfile that applies CORS changes to the official image
docker buildx create --use --name multi-platform-builder || true

# Build for linux/amd64 platform
docker buildx build \
  --platform linux/amd64 \
  -t $FULL_IMAGE_NAME \
  -f Dockerfile.Community \
  --push .

echo "Done! Your image is now available at: $FULL_IMAGE_NAME"
echo ""
echo "You can now use this image in your Railway deployment with:"
echo "FROM $FULL_IMAGE_NAME"
