# Using the official Ubuntu 20.04 base image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    g++ \
    libfftw3-dev \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    libhamlib++-dev \
    libasound2-dev \
    libpulse-dev \
    libopenjp2-7 \
    libopenjp2-7-dev \
    libv4l-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the source code to the container
COPY . /app

# Compile and install QSSTV
RUN mkdir src/build && \
    cd src/build && \
    qmake .. && \
    make -j2 && \
    make install && \
    cd / && \
    rm -rf /app

# Run QSSTV when the container starts
CMD ["qsstv"]
