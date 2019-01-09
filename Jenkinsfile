#!/usr/bin/env groovy
// please look at: https://jenkins.io/doc/book/pipeline/syntax/
BranchName = env.BRANCH_NAME
String param_string_cron = BranchName == "develop" ? "H H(20-21) * * * %buildType=PSRA \nH H(21-22) * * * %buildType=TICS \n H H(22-23) * * * %GenerateAPIDocs=true" : ""

def MailRecipient = 'DL_CDP2_Callisto@philips.com'
def LogLevel = env.Verbose

pipeline {
     agent {
        node {
            label 'xcode && 10.0'
        }
    }
    parameters {
        booleanParam(name: 'RemoveWorkspace', defaultValue: false, description: 'Remove Workspace')
        booleanParam(name: 'Verbose', defaultValue: false, description: 'Verbose logging')
        booleanParam(name: 'GenerateAPIDocs', defaultValue: false, description: 'Generate API Documentation')
    }
    triggers {
        parameterizedCron(param_string_cron)
    }
    environment {
        BUILD_FROM_ARTIFACTORY = 'false'
    }
    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '24'))
    }

    stages {

         stage ('Intialize Stage') {

            steps {
               echo "------------------Intializing----------------"
               echo "$BranchName"
               echo "$LogLevel"
               echo "$param_string_cron"
               sh 'which xcodebuild'
               sh 'xcodebuild -version'
               echo "------------------Intializing----------------"
            }
        }
        stage ('Compile Stage') {

            steps {
               sh 'pwd'
            }
        }

        stage ('Testing Stage') {

            steps {
               sh 'ls'
            }
        }


        stage ('Podspec Update Stage') {
            steps {
               sh 'ls'
            }
        }
        stage ('Deployment Stage') {
            steps {
               sh 'ls'
            }
        }
    }
}