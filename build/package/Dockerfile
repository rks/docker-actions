# syntax=docker/dockerfile:1

FROM debian:11.5-slim

COPY build/package/entrypoint.sh /entrypoint.sh

RUN env | sort

RUN --mount=type=secret,id=GITHUB_TOKEN echo "GITHUB_TOKEN=$(cat /run/secrets/GITHUB_TOKEN)"
RUN --mount=type=secret,id=SAMPLE echo "SAMPLE=$(cat /run/secrets/SAMPLE)"

RUN curl https://cli.github.com/packages/githubcli-archive-keyring.gpg --silent --location --output /usr/share/keyrings/githubcli-archive-keyring.gpg; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list; \
    apt-get update; \
    apt-get upgrade --assume-yes; \
    apt-get install --assume-yes gh git

RUN git clone https://github.com/rks/readme-readme-readme

ENTRYPOINT [ "/entrypoint.sh" ]
