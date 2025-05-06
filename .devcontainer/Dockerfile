FROM ubuntu:22.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Set non-interactive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get -y install --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    libstdc++-12-dev \
    clang \
    lld \
    nasm \
    rsync \
    texinfo \
    gcc-multilib \
    g++-multilib \
    python3 \
    qemu-system-i386 \
    qemu-utils \
    ccache \
    git \
    curl \
    wget \
    gperf \
    bison \
    flex \
    libmpfr-dev \
    libmpc-dev \
    libgmp-dev \
    e2fsprogs \
    mtools \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    libicu-dev \
    libssl-dev \
    libsqlite3-dev \
    libjpeg-dev \
    libpng-dev \
    libgif-dev \
    libxcb1-dev \
    libx11-dev \
    libxext-dev \
    libxft-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxrender-dev \
    libxfixes-dev \
    libxcb-keysyms1-dev \
    libxcb-render0-dev \
    libxcb-util-dev \
    libxcb-image0-dev \
    libxcb-icccm4-dev \
    libglu1-mesa-dev \
    libnss3-dev \
    libsoup2.4-dev \
    libharfbuzz-dev \
    sudo \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

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