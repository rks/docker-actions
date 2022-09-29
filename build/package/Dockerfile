# syntax=docker/dockerfile:1

ARG BASE_IMAGE_REGISTRY=mw-docker.repositories.mathworks.com
ARG BASE_IMAGE_NAME=golang
ARG BASE_IMAGE_TAG=1.19

FROM ${BASE_IMAGE_REGISTRY}/${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG} AS base

# Update system and install the `gh` command line tool
RUN curl https://cli.github.com/packages/githubcli-archive-keyring.gpg --silent --location --output /usr/share/keyrings/githubcli-archive-keyring.gpg; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list; \
    apt-get update; \
    apt-get upgrade --assume-yes; \
    apt-get install --assume-yes gh

COPY build/package/entrypoint.sh /docker/entrypoint.sh
COPY build/package/github-auth-entrypoint.sh /docker/github-auth-entrypoint.sh

RUN env | sort

RUN --mount=type=secret,id=GITHUB_TOKEN /docker/github-auth-entrypoint.sh git clone https://github.com/rks/readme-readme-readme

ENTRYPOINT [ "/entrypoint.sh" ]
