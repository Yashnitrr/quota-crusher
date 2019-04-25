# Terraform template- Subnet, Cloud NAT, and  Private GKE cluster

The Terraform template creates a new subnet and allows only the specific subnet to route via cloud NAT, it also creates a private GKE cluster, and deploys Istio with demo microservices


[Microservices Architecture](https://docs.google.com/presentation/d/1HAKWhTezFvcTG6b6OHpa_4DPSHyGTL5a359RIXwhnEI/edit?usp=sharing) and [Documentation](https://docs.google.com/document/d/1X_He7FWbJu88y9pR43YjkFxIGXHRdvTS0Vn0WsclW1s/edit?usp=sharing) of the demo deployment.


Instructions:

Note: The machine used to execute terraform must be in the same network as of gke cluster for network connections. Refer [private gke cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters)

1. Clone the repository
```
git clone <repo_link>
cd (..)PaloAlto-Terraform/
```

2. [Create a service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating_a_service_account) and grant the following roles to the service account by following these [instructions](https://cloud.google.com/iam/docs/granting-roles-to-service-accounts#granting_access_to_a_service_account_for_a_resource)
    1. roles/storage.admin
    2. roles/container.admin
    3. roles/compute.networkAdmin
    4. roles/iam.serviceAccountUser

3. [Install Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstarts)

4. [Activate the service account on gcloud sdk](https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account) and set the default project.
```
gcloud auth activate-service-account --key-file=SA_FILE.json
gcloud init
```

5. [Docker](https://docs.docker.com/install/) and [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) must be installed and running

6. Setup [helm](https://github.com/helm/helm), the template uses helm charts to deploy Istio in the GKE cluster.

7. Set the variables in [variables.tf](variables.tf) and corresponding service account filename in [provider_config.tf](provider_config.tf)

Terraform commands to setup the environment:
```
terraform init
terraform plan

terraform apply
```

Terraform commands to destroy the setup:
```
terraform destroy
```

## Test services with curl

1. Get JWT Token from demo application, visit [http://35.231.130.232](http://35.231.130.232) and login OKTA

2. Get Internal Load Balancers IP
```
kubectl get svc istio-ilbgateway -n istio-system | awk 'FNR == 2{print $4}'
```

3. Execute curl command on Graphql service using Internal Load Balancer
```
curl -k  -X POST -H "Authorization: Bearer <Token>" -H "Content-Type: application/json"   --data '{ "query": "{ ping express }"}' https://<ilb-gateway>/graphql
```

4. Execute curl command on SFDC service using Internal Load Balancer
```
curl -k -X GET -H "Authorization: Bearer <Token>" -H "Content-Type: application/json" https://<ilb-gateway>/api/v1/sfdc
```

## Troubleshooting

### Network failed to delete during terraform destroy

This occurs sometimes when Gogoles Kubernetes Engine cluster is destroyed however, GKE does not wait for the ingress controller to clean up resources. This results in orphaned firewall rules still attached with the network. If it occurs `delete the listed firewall rules manually and then run terraform destroy`
