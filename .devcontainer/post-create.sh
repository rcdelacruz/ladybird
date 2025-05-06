#!/bin/bash
set -e

# Script to run after the container is created
echo "======================================"
echo "Running post-creation setup for Ladybird"
echo "======================================"

# Function to print section headers
section_header() {
  echo ""
  echo "## $1"
  echo "-------------------------------------"
}

# Install additional dependencies
section_header "Installing additional dependencies"
sudo apt-get update
sudo apt-get install -y \
  libxcb-keysyms1-dev \
  libxcb-render0-dev \
  libxcb-util-dev \
  libxcb-image0-dev \
  libxcb-icccm4-dev \
  libxinerama-dev \
  libglu1-mesa-dev \
  libnss3-dev \
  libsoup2.4-dev \
  libharfbuzz-dev \
  libpng-dev \
  libjpeg-dev \
  libsqlite3-dev

# Clone submodules - Ladybird relies on submodules
section_header "Initializing submodules"
git submodule update --init --recursive || {
  echo "Failed to initialize submodules. This is required for Ladybird."
  echo "Trying a different approach..."
  git submodule update --init
  echo "Initialized top-level submodules. You may need to initialize nested submodules later."
}

# Set up the build directory
section_header "Setting up build directory"
mkdir -p Build
cd Build

# Configure the project with CMake
section_header "Configuring project with CMake"
cmake -GNinja ..

# The build command is commented out to avoid taking too long
# during container initialization. Uncomment if you want to build automatically.
# section_header "Building Ladybird (this may take a while)"
# ninja

section_header "Setup complete!"
echo "To build Ladybird:"
echo "  1. cd Build"
echo "  2. ninja"
echo ""
echo "This will take some time on the first build."
echo "======================================"
