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
# "-  Helper script to generate terraform variables        -"
# "-  file based on glcoud defaults.                       -"
# "-                                                       -"
# "---------------------------------------------------------"

# Stop immediately if something goes wrong
set -euo pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# This script should be run from directory that contains the terraform directory.
# The purpose is to populate defaults for subsequent terraform commands.

# git is required for this tutorial
command -v git >/dev/null 2>&1 || { \
 echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }

# glcoud is required for this tutorial
command -v gcloud >/dev/null 2>&1 || { \
 echo >&2 "I require gcloud but it's not installed.  Aborting."; exit 1; }


# gcloud config holds values related to your environment. If you already
# defined a default region we will retrieve it and use it
REGION="$(gcloud config get-value compute/region)"
if [[ -z "${GCP_REGION}" ]]; then
    echo "https://cloud.google.com/compute/docs/regions-zones/changing-default-zone-region" 1>&2
    echo "gcloud cli must be configured with a default region." 1>&2
    echo "run 'gcloud config set compute/region REGION'." 1>&2
    echo "replace 'REGION' with the region name like us-west1." 1>&2
    exit 1;
fi

# gcloud config holds values related to your environment. If you already
# defined a default zone we will retrieve it and use it
ZONE="$(gcloud config get-value compute/zone)"
if [[ -z "${GCP_ZONE}" ]]; then
    echo "https://cloud.google.com/compute/docs/regions-zones/changing-default-zone-region" 1>&2
    echo "gcloud cli must be configured with a default zone." 1>&2
    echo "run 'gcloud config set compute/zone ZONE'." 1>&2
    echo "replace 'ZONE' with the zone name like us-west1-a." 1>&2
    exit 1;
fi

# gcloud config holds values related to your environment. If you already
# defined a default project we will retrieve it and use it
PROJECT="$(gcloud config get-value core/project)"
if [[ -z "${GCP_PROJECT}" ]]; then
    echo "gcloud cli must be configured with a default project." 1>&2
    echo "run 'gcloud config set core/project PROJECT'." 1>&2
    echo "replace 'PROJECT' with the project name." 1>&2
    exit 1;
fi


# Use git to find the top-level directory and confirm
# by looking for the 'terraform' directory
PROJECT_DIR="$(git rev-parse --show-toplevel)"
if [[ -d "$ROOT/terraform" ]]; then
	PROJECT_DIR="$(pwd)"
fi
if [[ -z "${PROJECT_DIR}" ]]; then
    echo "Could not identify project base directory." 1>&2
    echo "Please re-run from a project directory and ensure" 1>&2
    echo "the .git directory exists." 1>&2
    exit 1;
fi


(
cd "${PROJECT_DIR}"

TFVARS_FILE="$ROOT/terraform/terraform.tfvars"

# We don't want to overwrite a pre-existing tfvars file
if [[ -f "${TFVARS_FILE}" ]]
then
    echo "${TFVARS_FILE} already exists." 1>&2
    echo "Please remove or rename before regenerating." 1>&2
    exit 1;
else
# Write out all the values we gathered into a tfvars file so you don't
# have to enter the values manually
    cat <<EOF > "${TFVARS_FILE}"
project="${GCP_PROJECT}"
region="${GCP_REGION}"
zone="${GCP_ZONE}"
vpc_network_name="${vpc_network_name}"
vpc_subnet_name="${vpc_subnet_name}"
subnet_cidr_range="${subnet_cidr_range}"
gcp_router_name="${gcp_router_name}"
gcp_nat_name="${gcp_nat_name}"
master_cidr_range="${master_cidr_range}"
authorized_cidr_range="${authorized_cidr_range}"
gke_initial_node="${gke_initial_node}"
gke_cluster_name="${gke_cluster_name}"
node_pool_name="${node_pool_name}"
min_master_version="${min_master_version}"
cluster_machine_type="${cluster_machine_type}"
min_node_count="${min_node_count}"
max_node_count="${max_node_count}"
sfdc_username="${sfdc_username}"
sfdc_password="${sfdc_password}"
istio_version="${istio_version}"
EOF
fi
)
