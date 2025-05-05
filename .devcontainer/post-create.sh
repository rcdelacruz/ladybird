#!/bin/bash

# Script to run after the container is created

echo "Running post-creation setup..."

# Ensure we have the latest package lists
sudo apt-get update

# Install any additional dependencies that might be needed
# These could be development-specific tools

# Clone submodules if they exist (Ladybird might use submodules)
git submodule update --init --recursive

# Set up build directory
mkdir -p Build
cd Build
cmake .. -GNinja

echo "Setup complete!"
