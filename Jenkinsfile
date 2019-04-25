#!/usr/bin/env groovy

def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(
  label: label,
  containers: [
    containerTemplate(name: 'nodejs', image: 'node:10', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)],
  volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]) {

    node(label) {
        stage ('Checkout') {
            checkout scm
        }
        stage ('Build') {
            container('nodejs') {
                sh """
                cd application/node-graphql
                npm install
                """
            }
        }
        stage ('Test With Coverage') {
            container('nodejs') {
                sh """
                cd application/node-graphql
                npm install mocha -g
                npm run coverage
                """
            }
        }
        stage ('Run Static Analysis') {
            container('nodejs') {
                sh """
                cd application/node-graphql
                npm run sonar
                """
            }
        }
        stage ('Check Coverage') {
            cobertura (
                autoUpdateHealth: false,
                autoUpdateStability: false,
                coberturaReportFile: '**/coverage/*.xml',
                conditionalCoverageTargets: '70, 0, 0',
                failUnhealthy: false,
                failUnstable: false,
                lineCoverageTargets: '80, 0, 0',
                maxNumberOfBuilds: 0,
                methodCoverageTargets: '80, 0, 0',
                onlyStable: false,
                sourceEncoding: 'ASCII',
                zoomCoverageChart: false
            )
        }
        stage ('Build Docker Image') {
            container ('docker') {
                sh """
                cd application/node-graphql
                docker build -t venky637/graphql:v1 .
                docker.withCredentials('docker') {
                  def customImage = docker.build("my-image:${env.BUILD_ID}")
                  /* Push the container to the custom Registry */
                  customImage.push()
                docker push venky637/graphql:v1
                """
            }
        }
    }
}
