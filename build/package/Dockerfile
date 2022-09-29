FROM debian:11.5-slim

COPY build/package/entrypoint.sh /entrypoint.sh

RUN echo "GH_ENTERPRISE_TOKEN=${GH_ENTERPRISE_TOKEN}"
RUN echo "GITHUB_TOKEN=${GITHUB_TOKEN}"


ENTRYPOINT [ "/entrypoint.sh" ]
