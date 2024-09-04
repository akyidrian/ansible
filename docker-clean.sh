#!/usr/bin/env bash
set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

IMAGE_NAME=ansible-tester
if docker images --format '{{.Repository}}' | grep -q "^${IMAGE_NAME}$"; then
    docker rmi -f "${IMAGE_NAME}"
fi
if docker images --format '{{.Repository}}' | grep -q "^<none>$"; then
    docker images -f "dangling=true" -q | xargs -r docker rmi -f
fi
