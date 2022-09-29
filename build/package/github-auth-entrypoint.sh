#!/bin/bash

set -e

# During `docker build` the token is provided as a Docker secret so that the token is not included
# in the image build cache. Docker mounts the secret as a file in /run/secrets.
#
# If the secret is present, read it into an environment variable.
if [ -f /run/secrets/GITHUB_TOKEN ]; then
    echo 'Secrets file exists'
    export GITHUB_TOKEN="${GITHUB_TOKEN:-$(cat /run/secrets/GITHUB_TOKEN)}"
else
    echo 'Secrets file does not exist'
fi

# If the token is present in an environment variable, use `gh` to authenticate.
if [ -n "${GITHUB_TOKEN}" ]; then
    echo 'Running gh auth setup-git'
    gh auth setup-git
else
    echo 'Not running gh auth setup-git'
fi

exec "$@"
