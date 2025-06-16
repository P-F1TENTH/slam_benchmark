#!/bin/bash

set -eu

docker build -f docker/base.Dockerfile --tag ros_base .

for slam in semantic_suma kiss_slam spark_fast_lio semantic_dsp_map lio_sam; do
    docker build -f docker/"$slam".Dockerfile --tag benchmark_"$slam" .
done
