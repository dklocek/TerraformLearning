pipeline {
    agent any
    environment {
            CREDENTIALS = credentials('.credential')
    }
    stages {
        stage('Example') {
            steps {
                sh "terraform init"
                sh "terraform plan -out plan.txt"

            }
        }
    }
}
