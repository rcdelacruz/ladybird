FROM ubuntu:22.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Set non-interactive frontend for apt and prevent errors
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update and install essential packages first
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    curl \
    wget \
    pkg-config \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install CMake 3.27.7 (modern version)
RUN wget https://github.com/Kitware/CMake/releases/download/v3.27.7/cmake-3.27.7-linux-x86_64.sh \
    -q -O /tmp/cmake-install.sh \
    && chmod u+x /tmp/cmake-install.sh \
    && mkdir -p /opt/cmake \
    && /tmp/cmake-install.sh --skip-license --prefix=/opt/cmake \
    && ln -s /opt/cmake/bin/* /usr/local/bin/ \
    && rm /tmp/cmake-install.sh

# Verify CMake version
RUN cmake --version

# Install development dependencies in smaller, more manageable groups
RUN apt-get update && apt-get install -y \
    clang \
    lld \
    python3 \
    gperf \
    bison \
    flex \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libicu-dev \
    libfreetype6-dev \
    libfontconfig1-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    libx11-dev \
    libxext-dev \
    libxft-dev \
    libxcursor-dev \
    libxrender-dev \
    libxfixes-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user with sudo access
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\\(root\\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set up the workspace directory and permissions
WORKDIR /workspace
RUN chown $USER_UID:$USER_GID /workspace

# Set the default user
USER $USERNAME

# Configure git for the user
RUN git config --global core.autocrlf input

# Restore interactive frontend
ENV DEBIAN_FRONTEND=dialog

# Set display for X11 forwarding if needed
ENV DISPLAY=:0