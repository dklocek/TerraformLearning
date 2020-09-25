pipeline {
    agent any

    environment{
        ACCOUNT_KEY = 'credentials.(creds)'
    }

    stages {
        stage('Example') {
            steps {
                sh 'echo $ACCOUNT_KEY > /home/creds/.cred'
                sh 'base64 -d /home/creds/.cred > /home/creds/.credentials'
                sh "terraform init"
                sh "terraform plan -out plan.txt"

            }
        }
    }
}
