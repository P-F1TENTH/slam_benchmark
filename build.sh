#!/bin/bash

set -eu

for slam in semantic_suma kiss_slam spark_fast_lio semantic_dsp_map lio_sam; do
    docker build -f docker/"$slam".Dockerfile --tag benchmark_"$slam" .
done
