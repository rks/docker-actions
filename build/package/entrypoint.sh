#!/bin/sh -l

echo "Running with args: ${@}"

env | sort

echo "GITHUB_TOKEN=${GITHUB_TOKEN}"
echo "SAMPLE=${SAMPLE}"
