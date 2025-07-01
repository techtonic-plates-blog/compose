#!/bin/sh

NETWORK_NAME="techtonic_plates_network"

if command -v docker >/dev/null 2>&1; then
    echo "Creating network with Docker..."
    docker network create "$NETWORK_NAME"
elif command -v podman >/dev/null 2>&1; then
    echo "Creating network with Podman..."
    podman network create "$NETWORK_NAME"
else
    echo "Neither Docker nor Podman is installed."
    exit 1
fi
