pipeline {
 
    agent any

    environment {
        PATH = "/usr/bin/python3;$PATH"
    }
 
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amoyse/jenkins-test-pyapp.git'
            }
        }
 
        stage('Prepare') {
            steps {
                sh 'pip3 install -r requirements.txt'
            }
        }
 
        stage('Test') {
            steps {
                sh 'python3 -m pytest test_routes.py'
            }
        }
 
        stage('SAST') {
            steps {
                sh 'safety check'
            }
        }
 
        stage('SCA') {
            steps {
                dependencyCheck additionalArguments: '', odcInstallation: 'OWASP-Dependency-Scan'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'Rack-Carbon-Verdict1', usernameVariable: 'amoyse42')]) {
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
