pipeline {
    agent any

    stages {

         stage ('Intialize Stage') {

            steps {
               echo "------------------Intializing----------------"
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