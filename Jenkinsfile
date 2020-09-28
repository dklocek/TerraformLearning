pipeline {
    agent any

    stages {
        stage('Example') {
            steps {
                withAWS(credentials: 'aws_creds', region: 'eu-west-1'){
                sh "terraform init"
                sh "terraform plan -out plan.txt"
                }

            }
        }
    }
}
