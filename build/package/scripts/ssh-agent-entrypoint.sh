#!/usr/bin/env bash

set -e

SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-/tmp/ssh-auth.sock}"

# If the SSH agent is not running, start it.
if [[ ! -S "${SSH_AUTH_SOCK}" ]]; then
    [[ "${DEBUG}" == "1" ]] && echo "Starting SSH agent"

    eval $(ssh-agent -a ${SSH_AUTH_SOCK} -t 10m) > /dev/null

    __sshAgentStarted=1
fi

GH_SSH_KEY_FILE="${GH_SSH_KEY_FILE:-$HOME/.ssh/id_ed25519}"
GH_SSH_KEY="${GH_SSH_KEY:-$(cat ${GH_SSH_KEY_FILE})}"

# If we have an SSH key, add it to the agent.
[[ -n "${GH_SSH_KEY}" ]] && echo "${GH_SSH_KEY}" | ssh-add -q -

# For Docker engines that use a VM (macOS, Windows).
# Could make an architecture check here.
SSH_AUTH_SOCK_MOUNT="${SSH_AUTH_SOCK_MOUNT:-${SSH_AUTH_SOCK}}"

# Set a variable that eval-ed code can look for
SSH_AGENT_ENTRYPOINT=on eval "${@}"

# If the SSH agent is running, and we started it, stop it.
if [[ -S "${SSH_AUTH_SOCK}" ]] && [[ $__sshAgentStarted == 1 ]]; then
    [[ "${DEBUG}" == "1" ]] && echo "Stopping SSH agent"

    eval $(ssh-agent -k -a $SSH_AUTH_SOCK) > /dev/null
fi
