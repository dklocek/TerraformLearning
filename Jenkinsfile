pipeline {
    agent any

    stages {
        stage('Example') {
            steps {
                sh "terraform init"
                sh "terraform plan -out plan.txt"

            }
        }
    }
}
