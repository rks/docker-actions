# syntax=docker/dockerfile:1

FROM debian:11.5-slim

COPY build/package/entrypoint.sh /entrypoint.sh

RUN env | sort

RUN --mount=type=secret,id=GITHUB_TOKEN echo "GITHUB_TOKEN=$(cat /run/secrets/GITHUB_TOKEN)"
RUN --mount=type=secret,id=SAMPLE echo "SAMPLE=$(cat /run/secrets/SAMPLE)"

RUN apt-get update; \
    apt-get upgrade; \
    apt-get install --assume-yes git

RUN git clone https://github.com/rks/readme-readme-readme

ENTRYPOINT [ "/entrypoint.sh" ]
