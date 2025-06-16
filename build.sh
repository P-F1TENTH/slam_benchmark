#!/bin/bash

set -eu

for dockerfile in docker/*.Dockerfile; do
    slam=$(basename "$dockerfile" .Dockerfile)
    docker build -f "$dockerfile" --tag "benchmark_${slam}" .
done

