#!/bin/bash

# Script to run after the container is created
echo "Running post-creation setup..."

# Ensure we have the latest package lists
sudo apt-get update

# Install any additional dependencies that might be needed
sudo apt-get install -y libx11-dev libxext-dev libxft-dev libxinerama-dev libxcursor-dev libxrender-dev libxfixes-dev libxcb-keysyms1-dev libxcb-render0-dev libxcb-util-dev libxcb-image0-dev libxcb-icccm4-dev mesa-common-dev libgl1-mesa-dev

# Clone submodules - Ladybird heavily relies on submodules
echo "Initializing submodules..."
git submodule update --init --recursive

# Configure Serenity build
echo "Setting up Serenity build environment..."
Meta/serenity.sh rebuild-toolchain
Meta/serenity.sh regenerate-all

# Set up build directory for Ladybird
echo "Setting up Ladybird build directory..."
mkdir -p Build
cd Build
cmake -GNinja -DBUILD_LAGOM=ON ..

# Build the project
echo "Building Ladybird browser..."
ninja

echo "Setup complete! You can now run Ladybird from the Build directory."
