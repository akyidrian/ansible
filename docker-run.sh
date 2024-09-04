#!/usr/bin/env bash
set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

CONTAINER_HOME=/home/tester
IMAGE_NAME=ansible-tester
CONTAINER_NAME="${IMAGE_NAME}"
docker run --rm \
    --user 1000:1000 `# tester:tester` \
    -e USER=tester \
    -v "$(pwd)":"${CONTAINER_HOME}/ansible" \
    -v ~/.ssh:"${CONTAINER_HOME}/.ssh" \
    --name "${CONTAINER_NAME}" \
    -it "${IMAGE_NAME}"
