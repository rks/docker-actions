#!/bin/bash

set -e

# During `docker build` the token is provided as a Docker secret so that the token is not included
# in the image build cache. Docker mounts the secret as a file in /run/secrets.
#
# If the secret is present, read it into an environment variable.
if [ -f /run/secrets/GH_TOKEN ]; then
    export GH_TOKEN="${GH_TOKEN:-$(cat /run/secrets/GH_TOKEN)}"
fi

# If the token is present in an environment variable, use `gh` to authenticate.
if [ -n "${GH_TOKEN}" ]; then
    gh auth login
    gh auth setup-git
fi

exec "$@"
