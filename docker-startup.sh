#!/bin/sh

set -eu

if [ -n "${AWS_CONTAINER_CREDENTIALS_RELATIVE_URI:-}" ]; then
  # Looks like we're in ECS and we've got access to credentials.
  # Use Chamber so we can use them to get secrets from Parameter Store
  AWS_REGION=${ECS_AWS_REGION} ./chamber--linux-amd64 exec ${ECS_SERVICE} -- npm start
else
  # Do a normal startup
  npm start
fi
