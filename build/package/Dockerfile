# syntax=docker/dockerfile:1

ARG BASE_IMAGE_REGISTRY=mw-docker.repositories.mathworks.com
ARG BASE_IMAGE_NAME=golang
ARG BASE_IMAGE_TAG=1.19

FROM ${BASE_IMAGE_REGISTRY}/${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG} AS base

ARG WORKDIR=/mw

WORKDIR ${WORKDIR}

COPY build/package/known_hosts /docker/known_hosts

RUN apt-get update; \
    apt-get upgrade --assume-yes; \
    mkdir --parents --mode 0700 $HOME/.ssh; \
    mv /docker/known_hosts $HOME/.ssh/known_hosts; \
    chmod 0400 $HOME/.ssh/known_hosts

RUN --mount=type=ssh git clone git@github.com:rks/readme-readme-readme.git clone-build
