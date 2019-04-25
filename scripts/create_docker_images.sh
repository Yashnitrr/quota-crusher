#!/usr/bin/env bash

# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# "---------------------------------------------------------"
# "-                                                       -"
# "-   Helper script to create docker images and update    -"
# "-   cluster with latest images                          -"
# "-                                                       -"
# "---------------------------------------------------------"


# Stop immediately if something goes wrong
set -euo pipefail

fail() {
  echo "ERROR: ${*}"
  exit 2
}

usage() {
  cat <<-EOM
USAGE: $(basename "$0") <action>
Where the <action> can be:
  auto
  auth-docker
  del-images
  build-sfdc
  build-express
  build-graphql
  prepare-cluster
  install-app
EOM
  exit 1
}

# Authenticate docker to use gcr.io
auth_docker() {
  command = <<EOF
echo y | gcloud auth configure-docker
EOF
}

del_images() {
  command = <<EOF
gcloud container images delete gcr.io/${PROJECT}/graphql:v1
gcloud container images delete gcr.io/${PROJECT}/express:v1
gcloud container images delete gcr.io/${PROJECT}/sfdc:v1
rm -rf ${path.module}/*.pem
rm -rf ${path.module}/mod_deployment.yaml
EOF
}

# Builds docker image for sfdc service
build_sfdc_image() {
  command = <<EOF
cd ${path.module}/Docker/node-sfdc/ \
&& docker build -t sfdc:v1 . \
&& docker tag sfdc:v1 gcr.io/${PROJECT}/sfdc:v1 \
&& docker push gcr.io/${PROJECT}/sfdc:v1
EOF
}

# Builds docker image for express service
build_express_image() {
  command = <<EOF
cd ${path.module}/Docker/node-express/ \
&& docker build -t express:v1 . \
&& docker tag express:v1 gcr.io/${PROJECT}/express:v1 \
&& docker push gcr.io/${PROJECT}/express:v1
EOF
}

# Builds docker image for graphql service
build_graphql_image() {
    command = <<EOF
cd ${path.module}/Docker/node-graphql/ \
&& docker build -t graphql:v1 . \
&& docker tag graphql:v1 gcr.io/${$PROJECT}/graphql:v1 \
&& docker push gcr.io/${PROJECT}/graphql:v1
EOF
}



# Installs the Quartercrusher app
install_app() {
  echo "Installing Panw's Quartercrusher app"
  kubectl apply -f "${REPO_HOME}/manifests/deployment.yaml"
}

# Prepare cluster for deployment
prepare_cluster() {

  # Acquire the kubectl credentials
  gcloud container clusters get-credentials "${CLUSTER_NAME}" \
    --region "${GCLOUD_REGION}" \
    --project "${GCLOUD_PROJECT}"

  # Bind the cluster-admin ClusterRole to your user account
  kubectl -n default create clusterrolebinding cluster-admin-binding \
    --clusterrole cluster-admin \
    --user "$(gcloud config get-value account)"

  # Deploy the example application
  install_app
}

# Run as a fully automated way
auto() {
  auth-docker
  del-images
  build-sfdc
  build-express
  build-graphql
  prepare-cluster
  install-app
}

main() {
  # The absolute path to the root of the repository
  SCRIPT_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  REPO_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

  # Validate that this workstation has access to the required executables
  command -v kubectl >/dev/null || fail "kubectl is not installed!"
  command -v gcloud >/dev/null || fail "gcloud is not installed!"
  command -v jq >/dev/null || fail "jq is not installed!"

  # Validate the number of command line arguments
  if [[ $# -lt 1 ]]; then
    usage
  fi

  # Source the properties file
  if [ -f "${REPO_HOME}/.env" ] ; then
    # shellcheck source=.env
    source "${REPO_HOME}/.env"
  else
    echo "ERROR: Define a properties file '.env'"
    exit 1
  fi

  CLOUDSDK_CORE_DISABLE_PROMPTS=0
  export CLOUDSDK_CORE_DISABLE_PROMPTS

  # Set GCLOUD_REGION to default if it has not yet been set
  GCLOUD_REGION_DEFAULT=$(gcloud config get-value compute/region)
  if [ "${GCLOUD_REGION_DEFAULT}" == "(unset)" ]; then
  # check if defined in env file
  if [ -z ${GCLOUD_REGION:+exists} ]; then
    fail "GCLOUD_REGION is not set"
  fi
  else
  GCLOUD_REGION="$GCLOUD_REGION_DEFAULT"
  export GCLOUD_REGION
  fi

  # Set GCLOUD_PROJECT to default if it has not yet been set
  GCLOUD_PROJECT_DEFAULT=$(gcloud config get-value project)
  if [ "${GCLOUD_PROJECT_DEFAULT}" == "(unset)" ]; then
  # check if defined in env file
  if [ -z ${GCLOUD_PROJECT:+exists} ]; then
    fail "GCLOUD_PROJECT is not set"
  fi
  else
  GCLOUD_PROJECT="$GCLOUD_PROJECT_DEFAULT"
  export GCLOUD_PROJECT
  fi

  # Set CLUSTER_NAME
  if [ -z ${CLUSTER_NAME:+exists} ]; then
    CLUSTER_NAME="blue-green-test"
    if [ ! -z ${BUILD_NUMBER:+exists} ]; then
      CLUSTER_NAME="${CLUSTER_NAME}-${BUILD_NUMBER}"
    fi
    export CLUSTER_NAME
  fi


  # Validate the number of command line arguments
  if [[ $# -lt 1 ]]; then
    usage
  fi

  ACTION=$1
  case "${ACTION}" in
    auto)
      CLOUDSDK_CORE_DISABLE_PROMPTS=1
      export CLOUDSDK_CORE_DISABLE_PROMPTS
      auto
      unset CLOUDSDK_CORE_DISABLE_PROMPTS
      ;;
    auth-docker)
      auth_docker
      ;;
    del-images)
      del_images
      ;;
    build-sfdc)
      build_sfdc_image
      ;;
    build-express)
      build_express_image
      ;;
    build-graphql)
      build_graphql_image
      ;;
    prepare-cluster)
      prepare_cluster
      ;;
    install-app)
      install_app
      ;;
    *)
      usage
      ;;
  esac
}

main "$@"
