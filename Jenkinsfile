def  VERSION = "v1"
def  PROJECT_ID= "palo-alto-networks-234507"
def  sfdcimageTag = "gcr.io/${PROJECT_ID}/cicd/sfdc:${VERSION}"
def  graphqlimageTag = "gcr.io/${PROJECT_ID}/cicd/graphql:${VERSION}"
def  expressimageTag = "gcr.io/${PROJECT_ID}/cicd/express:${VERSION}"
def  namespace = "palo-alto-demo"

pipeline {
    agent any
    stages {
    stage('Setup') {
      steps {
      // checkout code from scm i.e. commits related to the PR
      checkout scm
      }
    }
    stage('Build Docker Images') {
      steps {
              //Build python flask application image
              sh "PYTHONUNBUFFERED=1 sudo docker build ./microservices/node-sfdc -t ${sfdcimageTag}"
              //Build graphql image
              sh "PYTHONUNBUFFERED=1 sudo docker build ./microservices/node-graphql -t ${graphqlimageTag}"
              //Build customer image
              sh "PYTHONUNBUFFERED=1 sudo docker build ./microservices/node-express -t ${expressimageTag}"
      }
    }
    stage('Push Docker Image to GCR'){
      steps {
              sh "PYTHONBUFFERED=1 sudo gcloud docker -- push ${sfdcimageTag} "
              sh "PYTHONBUFFERED=1 sudo gcloud docker -- push ${graphqlimageTag}"
              sh "PYTHONBUFFERED=1 sudo gcloud docker -- push ${expressimageTag}"
       }
      }
    stage('Deploy on GKE'){
      steps {
              sh "sudo su"
              //sh "PYTHONBUFFERED=1 sudo openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/tls.crt -keyout /etc/tls.key -subj '/C=US/ST=California/L=San Francisco/O=Global Security/OU=IT Department/CN=agrawaly@google.com'"
              sh "PYTHONBUFFERED=1 sudo gcloud container clusters get-credentials istio-tf --region us-west1 --project palo-alto-networks-234507"
              //sh "PYTHONBUFFERED=1 sudo kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin"
              //sh "PYTHONBUFFERED=1 sudo kubectl delete namespace palo-alto-demo"
              //sh "PYTHONBUFFERED=1 sudo kubectl create namespace palo-alto-demo"
              //sh "PYTHONBUFFERED=1 sudo kubectl create -n palo-alto-demo secret tls istio-ingressgateway-certs --key /etc/tls.key --cert /etc/tls.crt"
              //sh "PYTHONBUFFERED=1 sudo kubectl label namespace default istio-injection=enabled"
              //sh "PYTHONBUFFERED=1 sudo kubectl label namespace palo-alto-demo istio-injection=enabled"
              sh "PYTHONBUFFERED=1 sudo kubectl apply -f deployment.yaml"
        }
      }
    }
  }
