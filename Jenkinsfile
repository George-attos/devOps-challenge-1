pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "georgeattos/devops-challenge"
        DOCKER_TAG = "mulearn_devops_challenge_1"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/George-attos/devOps-challenge-1.git'
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t $DOCKER_IMAGE:$DOCKER_TAG -f Dockerfile ."
            }
        }

        stage('Test') {
            steps {
                script {
                    echo 'Running tests inside Docker container...'
                    // Run pytest from /app (root) and let it discover all tests recursively
                    def testStatus = sh(
                        script: "docker run --rm $DOCKER_IMAGE:$DOCKER_TAG pytest /app --maxfail=1 --disable-warnings",
                        returnStatus: true
                    )
                    if (testStatus != 0) {
                        error("Tests failed inside Docker container")
                    }
                }
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerID', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh "docker push $DOCKER_IMAGE:$DOCKER_TAG"
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker rm -f mu-do-C1 || true'
                sh "docker run -d -p 5000:5000 --name mu-do-C1 $DOCKER_IMAGE:$DOCKER_TAG"
            }
        }
    }
}
