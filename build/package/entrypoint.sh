#!/bin/sh -l

echo "Hello $1"

echo "$(env | sort)"
