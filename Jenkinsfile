#!groovy

// This Jenkinsfile is used to build, test, and generate code coverage for an iOS project
// If you want to use this Jenkinsfile with your own project you'll need to make some changes:
// 1. Change the following variables to match your project
def xcodeproj = 'Jenkins iOS Example.xcodeproj' // Path to the xcodeproj
def xcarchive_name = "Jenkins iOS Example.xcarchive" // Name of the archive to build
def build_scheme = 'Jenkins iOS Example' // Scheme to build the app
def test_scheme = 'Jenkins iOS Example' // Scheme to build tests
def simulator_device = 'iPhone 7' // Name of the device type to use for tests
// 2. If you want to upload builds to a server, update the buildURL variable and uncomment the scp command under stage('Save')
// 3. If you want Slack notifications, return true in the functions below and set the Slack channel
def slackChannel = '#general'

@Library('shared') _

def sendStartNotification() {
    // Send a Slack notification when the build starts?
    false
}

def sendSuccessNotification() {
    // Send a Slack notification when the build succeeds?
    false
}

def sendUnstableNotification() {
    // Send a Slack notification when the build is unstable (such as when tests fail)?
    false
}

def sendFailNotification() {
    // Send a Slack notification when the build fails (such as build failures)?
    false
}

def slackMessagePrefix() {
    // Generate a nicer name for branches in Slack notifications
    // Converts Job Name/feature%2Fnew-feature to Job Name - feature/new-feature
    def jobName = env.JOB_NAME.replaceAll("/", " - ").replaceAll("%2F", "/")

    "${jobName} - #${env.BUILD_NUMBER}"
}

node('iOS Node') {  
  
  stage('Checkout/Build/Test') {
    
}

stage ('Notify') {
    
}

}
