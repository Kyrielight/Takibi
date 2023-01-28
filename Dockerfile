
# Provided by BuildKit.
# Do not redeclare target variables as they are already
# available globally, and would be reset.
FROM --platform=linux/${TARGETARCH} ubuntu:22.04

# Redeclare in FROM scope
ARG TARGETARCH
RUN echo ${TARGETARCH}

WORKDIR /opt/takibi

# Install CircleCI image dependencies
RUN apt update -y && apt install -y \
    git \
    ssh \
    tar \
    gzip \
    ca-certificates

# Install OpenJDK
RUN apt install -y \
    apt-transport-https \
    build-essential \
    openjdk-11-jdk-headless \
    wget 

# Install Bazelisk to the PATH
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.15.0/bazelisk-linux-${TARGETARCH} && \
    chmod +x bazelisk-linux-${TARGETARCH} && \
    mv bazelisk-linux-${TARGETARCH} /usr/local/bin/bazel