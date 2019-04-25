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
# "-  Helper script to generate deployment variables       -"
# "-  based on a pullrequest.                              -"
# "-                                                       -"
# "---------------------------------------------------------"

# bash "strict-mode", fail immediately if there is a problem
set -euo pipefail

if [[ -z "${ghprbPullId}" && ${ghprbTargetBranch == "feature/*" ]]; then
  echo "The environment will be set to development" 1>&2
  GCP_PROJECT="panw-qc-dev-project"
  GCP_REGION="us-west1"
  GCP_ZONE="us-west1-a"
  vpc_network_name="default"
  vpc_subnet_name="istio"
  subnet_cidr_range="192.168.0.0/24"
  gcp_router_name="istio-demo"
  gcp_nat_name="istio-nat"
  master_cidr_range="172.16.0.0/28"
  authorized_cidr_range="10.138.0.0/20"
  gke_initial_node="1"
  gke_cluster_name="istio-tf"
  node_pool_name="istio-demo-nodes"
  min_master_version="1.12.7-gke.7"
  cluster_machine_type="n1-standard-2"
  min_node_count="1"
  max_node_count="6"
  sfdc_username=""
  sfdc_password=""
  istio_version="1.1.3"

elif [[ -z "${ghprbPullId}" && ${ghprbTargetBranch == "develop" ]]; then
  echo "The environment will be set to integration" 1>&2
  GCP_PROJECT="panw-qc-integration-project"
  GCP_REGION="us-west1"
  GCP_ZONE="us-west1-a"
  vpc_network_name="default"
  vpc_subnet_name="istio"
  subnet_cidr_range="192.168.0.0/24"
  gcp_router_name="istio-demo"
  gcp_nat_name="istio-nat"
  master_cidr_range="172.16.0.0/28"
  authorized_cidr_range="10.138.0.0/20"
  gke_initial_node="1"
  gke_cluster_name="istio-tf"
  node_pool_name="istio-demo-nodes"
  min_master_version="1.12.7-gke.7"
  cluster_machine_type="n1-standard-2"
  min_node_count="1"
  max_node_count="6"
  sfdc_username=""
  sfdc_password=""
  istio_version="1.1.3"

elif [[ -z "${ghprbPullId}" && ${ghprbTargetBranch == "release/*" ]]; then
  echo "The environment will be set to staging" 1>&2
  GCP_PROJECT="panw-qc-staging-project"
  GCP_REGION="us-west1"
  GCP_ZONE="us-west1-a,us-west1-b,uswest1-c"
  vpc_network_name="default"
  vpc_subnet_name="istio"
  subnet_cidr_range="192.168.0.0/24"
  gcp_router_name="istio-demo"
  gcp_nat_name="istio-nat"
  master_cidr_range="172.16.0.0/28"
  authorized_cidr_range="10.138.0.0/20"
  gke_initial_node="1"
  gke_cluster_name="istio-tf"
  node_pool_name="istio-demo-nodes"
  min_master_version="1.12.7-gke.7"
  cluster_machine_type="n1-standard-2"
  min_node_count="1"
  max_node_count="6"
  sfdc_username=""
  sfdc_password=""
  istio_version="1.1.3"

elif [[ -z "${ghprbPullId}" && ${ghprbTargetBranch == "hotfix/*" ]]; then
  echo "The environment will be set to staging" 1>&2
  GCP_PROJECT="panw-qc-staging-project"
  GCP_REGION="us-west1"
  GCP_ZONE="us-west1-a,us-west1-b,us-west1-c"
  vpc_network_name="default"
  vpc_subnet_name="istio"
  subnet_cidr_range="192.168.0.0/24"
  gcp_router_name="istio-demo"
  gcp_nat_name="istio-nat"
  master_cidr_range="172.16.0.0/28"
  authorized_cidr_range="10.138.0.0/20"
  gke_initial_node="1"
  gke_cluster_name="istio-tf"
  node_pool_name="istio-demo-nodes"
  min_master_version="1.12.7-gke.7"
  cluster_machine_type="n1-standard-2"
  min_node_count="1"
  max_node_count="6"
  sfdc_username=""
  sfdc_password=""
  istio_version="1.1.3"

elif [[ -z "${ghprbPullId}" && ${ghprbTargetBranch == "master" ]]; then
  echo "The environment will be set to production" 1>&2
  GCP_PROJECT="panw-qc-project"
  GCP_REGION="us-west1"
  GCP_ZONE="us-west1-a,us-west1-b,us-west1-c"
  vpc_network_name="default"
  vpc_subnet_name="istio"
  subnet_cidr_range="192.168.0.0/24"
  gcp_router_name="istio-demo"
  gcp_nat_name="istio-nat"
  master_cidr_range="172.16.0.0/28"
  authorized_cidr_range="10.138.0.0/20"
  gke_initial_node="1"
  gke_cluster_name="istio-tf"
  node_pool_name="istio-demo-nodes"
  min_master_version="1.12.7-gke.7"
  cluster_machine_type="n1-standard-2"
  min_node_count="1"
  max_node_count="6"
  sfdc_username=""
  sfdc_password=""
  istio_version="1.1.3"

elif [[ -z "${ghprbPullId}" && ${ghprbTargetBranch == "*" ]]; then
  echo "I am going to build but not deploy anywhere" 1>&2
  GCP_PROJECT=""
  GCP_REGION=""
  GCP_ZONE=""
  vpc_network_name=""
  vpc_subnet_name=""
  subnet_cidr_range=""
  gcp_router_name=""
  gcp_nat_name=""
  master_cidr_range=""
  authorized_cidr_range=""
  gke_initial_node=""
  gke_cluster_name=""
  node_pool_name=""
  min_master_version=""
  cluster_machine_type=""
  min_node_count=""
  max_node_count=""
  sfdc_username=""
  sfdc_password=""
  istio_version=""
fi
