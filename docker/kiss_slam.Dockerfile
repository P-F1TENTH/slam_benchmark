FROM python:3.10-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libeigen3-dev \
    libsuitesparse-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install kiss-slam

CMD ["kiss_slam_pipeline", "--help"]
