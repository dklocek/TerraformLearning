pipeline {
    agent any
    environment {
            aws_access_key_id = credentials(aws_access_key_id)
            aws_secret_access_key = credentials(aws_secret_access_key)
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
