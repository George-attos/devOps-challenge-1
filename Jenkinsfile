pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "georgeattos/devops-challenge"
        DOCKER_TAG = "mulearn_devops_challenge_1"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                git branch: 'main', url: 'https://github.com/George-attos/devOps-challenge-1.git'
            }
        }

        stage('Verify Docker Access') {
            steps {
                echo 'Verifying Docker access inside Jenkins...'
                sh 'docker ps'
            }
        }

        stage('Build and Push') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'

                    withCredentials([usernamePassword(credentialsId: 'dockerID', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        echo 'Pushing Docker image to Docker Hub...'
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying container...'
                    sh 'docker rm -f mu-do-C1 || true'
                    sh 'docker run -d -p 5000:5000 --name mu-do-C1 $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }
    }
}
