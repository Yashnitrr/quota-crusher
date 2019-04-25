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

# bash "strict-mode", fail immediately if there is a problem

set -euo pipefail

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
