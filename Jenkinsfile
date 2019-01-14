#!/usr/bin/env groovy
// please look at: https://jenkins.io/doc/book/pipeline/syntax/
BranchName = env.BRANCH_NAME
String param_string_cron = BranchName == "develop" ? "H H(20-21) * * * %buildType=PSRA \nH H(21-22) * * * %buildType=TICS \n H H(22-23) * * * %GenerateAPIDocs=true" : ""

def MailRecipient = 'mhhashim@gmail.com'
def LogLevel = env.Verbose

pipeline {
    //  agent {
    //     node {
    //         label 'xcode && 10.0'
    //     }
    // }
    agent any
    parameters {
        booleanParam(name: 'RemoveWorkspace', defaultValue: false, description: 'Remove Workspace')
        booleanParam(name: 'Verbose', defaultValue: false, description: 'Verbose logging')
        booleanParam(name: 'GenerateAPIDocs', defaultValue: false, description: 'Generate API Documentation')
        choice(choices: 'Normal\nHockyApp\nTICS', description: 'What type of build to build?', name: 'buildType')
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
               echo "Branch:$BranchName"
               echo "Loglevel:$LogLevel"
               echo "ParamString:$param_string_cron"
               sh 'which xcodebuild'
               sh 'xcodebuild -version'
               //sh 'pod --version'
               echo "------------------Intializing----------------"
               script {
                    if (params.RemoveWorkspace || (params.buildType == 'TICS')) {
                        echo "Removing Workspace per user choice"
                        deleteDir()
                        checkout scm
                    } else {
                        echo "Skipping Workspace removal and Removing results and ipa files from path"
                        sh "pwd"
                        sh "rm -rf Source/results/*"
                        sh "rm -rf Source/build/*.ipa"
                    }
                    sh "rm -rf ~/Library/Developer/Xcode/DerivedData"
                    sh "rm -rf Source/DerivedData"
                }
                InitialiseBuild()
                //updatePods("Source",LogLevel)
                }
            }
        stage ('Zip Components') {

            steps {
               sh 'pwd'
            }
        }


     stage('Build and Unit Tests') {
            steps {
                script {
                    runTestsWith(true, "TestJenkins", "TestJenkins")
                    //runTestsWith(true, "PhilipsIconFontDLSDev", "PhilipsIconFontDLS")
                }
            }
            post {
                always{
                    checkBuildResult()
                }
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
    post {
        always{
            step([$class: 'Mailer', notifyEveryUnstableBuild: true, recipients: MailRecipient, sendToIndividuals: true])
        }
    }
}

def InitialiseBuild() {
    committerName = sh (script: "git show -s --format='%an' HEAD", returnStdout: true).trim()
    currentBuild.description = "Submitter: " + committerName + ";Node: ${env.NODE_NAME}"
    echo currentBuild.description

    if (params.buildType == 'TICS') {
        currentBuild.displayName = "${env.BUILD_NUMBER}-TICS"
    }
    if (params.buildType == 'HockyApp') {
        currentBuild.displayName = "${env.BUILD_NUMBER}-HockyApp"
    }
     if (params.buildType == 'Normal') {
        currentBuild.displayName = "${env.BUILD_NUMBER}-Normal"
    }

    echo currentBuild.displayName
}


def runTestsWith(Boolean isWorkspace, String testSchemeName, String frameworkName = " ", Boolean isApp = false, Boolean hasCucumberOutput = false) {

    // This is only used for code coverage and test result output/attachments
    def resultBundlePath = "results/" + testSchemeName
    def binaryPath = frameworkName  + "/"+ frameworkName + ".framework/" + frameworkName
    if (isApp) {
        binaryPath = frameworkName+ ".app"  + "/" + frameworkName
    }
    Boolean generateLLVMFile = false
    if(getSkipComponentsForLLVMReport().contains(frameworkName)){
      generateLLVMFile = false
    }

    def testScript = """
        #!/bin/bash -l

        killall Simulator || true
        xcrun simctl erase all || true

        cd ${"TestJenkins"}

        #Set XCPretty output format
        export LC_CTYPE=en_US.UTF-8

        xcodebuild test \
                -project ${"TestJenkins.xcodeproj"} \
                -scheme ${testSchemeName} CLANG_WARN_DOCUMENTATION_COMMENTS='NO'\
                -destination \'platform=iOS Simulator,name=iPhone 8,OS=latest\' \
                -resultBundlePath ${resultBundlePath} \
                | xcpretty --report junit --report html
               

      
    """

    echo testScript
    sh testScript

 
}

def checkBuildResult() {
    echo "currentBuild result is ${currentBuild.result}"
    if (currentBuild.result == 'UNSTABLE') {
        currentBuild.result = 'FAILED'
        echo "currentBuild result set to ${currentBuild.result}"
    }
}

def getSkipComponentsForLLVMReport() {
  return ["ConsentWidgetsDev","ConsentAccessToolKitDev","PlatformInterfacesDev"]
}


