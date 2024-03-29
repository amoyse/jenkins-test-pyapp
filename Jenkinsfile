pipeline {
 
    agent any

 
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amoyse/jenkins-test-pyapp.git'
            }
        }
 
        stage('Prepare') {
            steps {
                sh 'python3 -m pip install -r requirements.txt'
            }
        }
 
        stage('Test') {
            steps {
                sh 'python3 -m pytest test_routes.py'
            }
        }
 
        stage('SAST') {
            steps {
                sh 'python3 -m safety check -r requirements.txt'
            }
        }
 
 
        stage('Build') {
            steps {
                script {
                    sh 'docker build -t amoyse42/jenkins-test-pyapp .'
                }
            }
        }
 
        stage('Deploy') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dhpass', usernameVariable: 'dhuser')]) {
                        sh 'docker login -u ${dhuser} -p ${dhpass}'
                        sh 'docker push amoyse42/jenkins-test-pyapp'
                    }
                }
            }
        }
 
        stage('DAST') {
            steps {
                script {
                    sh 'trivy image amoyse42/jenkins-test-pyapp'
                }
            }
        }
 
    }
 
}
