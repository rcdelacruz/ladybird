FROM ubuntu:22.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install necessary dependencies
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    build-essential \
    cmake \
    gdb \
    git \
    make \
    ninja-build \
    pkg-config \
    libpulse-dev \
    libglib2.0-dev \
    libwebkit2gtk-4.0-dev \
    libgtk-3-dev \
    libcairo2-dev \
    libssl-dev \
    libicu-dev \
    libfreetype6-dev \
    libgcrypt20-dev \
    libnotify-dev \
    libsoup2.4-dev \
    libxkbcommon-dev \
    libegl1-mesa-dev \
    curl \
    wget \
    sudo \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Create a non-root user with sudo access
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set up the workspace directory
WORKDIR /workspace

# Set the default user
USER $USERNAME

ENV DISPLAY=:0