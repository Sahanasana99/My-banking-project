pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Sahanasana99/My-banking-project.git'
            }
        }
        stage('Build Package') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('HTML Reports') {
            steps {
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking-project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
         stage('Build Docker image') {
            steps {
                sh 'docker build -t ssahana99/my-banking-project:1.0 .'
            }
        }
        stage('Docker Push Image') {
            steps {
               withCredentials([usernamePassword(credentialsId: 'Docker-hub', passwordVariable: 'docker_password', usernameVariable: 'docker_login')]) {
               sh 'docker login -u ${docker_login} -p ${docker_password}'
                        }
               sh 'docker push ssahana99/my-banking-project:1.0'
            }    
        }
    }
 }
