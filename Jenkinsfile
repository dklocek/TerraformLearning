pipeline {
    agent any

    environment{
        ACCOUNT_KEY = credentials.(creds)
    }

    stages {
        stage('Example') {
            steps {
                sh 'echo $ACCOUNT_KEY > /home/creds/.credentials'
                sh "terraform init"
                sh "terraform plan -out plan.txt"

            }
        }
    }
}
