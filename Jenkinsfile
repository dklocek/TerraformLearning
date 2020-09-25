pipeline {
    agent any

    environment{
        ACCOUNT_KEY = credentials.('.credentials')
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
