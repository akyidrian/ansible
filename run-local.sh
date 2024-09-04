#!/usr/bin/env bash
#
# Run Ansible playbook locally
#
set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

readonly ANSIBLE_GITHUB_URL="https://github.com/akyidrian/ansible.git"
declare SCRIPT_NAME SCRIPTS_DIR DOWNLOAD_DIR
SCRIPT_NAME=$(basename "${0}")
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOWNLOAD_DIR=$(mktemp -d -p /tmp "${SCRIPT_NAME}.XXXXXX")
readonly SCRIPT_NAME SCRIPTS_DIR DOWNLOAD_DIR

finish() {
    rm -rf "${DOWNLOAD_DIR}"
}
trap finish ERR EXIT

main() {
    sudo apt-get update && sudo apt-get install ansible git -y
    git clone --depth 1 --branch main "${ANSIBLE_GITHUB_URL}" "${DOWNLOAD_DIR}"
    (
        cd "${DOWNLOAD_DIR}" || exit
        ansible-playbook --inventory localhost, --connection local --ask-vault-pass "${SCRIPTS_DIR}/playbook.yml"
    )
}
main "${@}"
