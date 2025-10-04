#!/bin/bash

# Exit on error
set -e

# Check if version argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <version> [rollback]"
  exit 1
fi

VERSION=$1
ACTION=${2:-deploy}

if [ "$ACTION" = "deploy" ]; then
  echo "Building and deploying version $VERSION..."
  
  # Build and push the Docker image
  docker build -t yourusername/chemvr:$VERSION .
  docker push yourusername/chemvr:$VERSION
  
  # Update the deployment
  kubectl set image deployment/chemvr chemvr=yourusername/chemvr:$VERSION -n chemvr
  
  # Monitor the rollout
  echo "Monitoring deployment..."
  kubectl rollout status deployment/chemvr -n chemvr
  
  echo "\nDeployment successful!"
  
elif [ "$ACTION" = "rollback" ]; then
  echo "Rolling back deployment..."
  kubectl rollout undo deployment/chemvr -n chemvr
  
  echo "\nRollback complete!"
  
  # Get current version
  kubectl get deployment chemvr -n chemvr -o=jsonpath='{.spec.template.spec.containers[0].image}'
  echo ""
  
else
  echo "Invalid action. Use 'deploy' or 'rollback'."
  exit 1
fi
