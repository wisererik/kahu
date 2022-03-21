#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

MODULE_ROOT=github.com/soda-cdm/kahu
SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..

if [[ ! -d "${GOPATH}/src/k8s.io/code-generator" ]]; then
  echo "code-generator is missing from GOPATH"
  exit 1
fi

bash ${GOPATH}/src/k8s.io/code-generator/generate-groups.sh \
  all \
  "${MODULE_ROOT}"/pkg/generated \
  "${MODULE_ROOT}"/pkg/apis \
  kahu:v1 \
  --output-base "$(dirname "${BASH_SOURCE[0]}")/../../.." \
  --go-header-file "${SCRIPT_ROOT}"/hack/boilerplate.go.txt
