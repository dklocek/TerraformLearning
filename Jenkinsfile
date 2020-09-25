pipeline {
    agent any

    environment{
        ACCOUNT_KEY = credentials.(creds)
    }

    stages {
        stage('Example') {
            steps {
                sh 'echo ----------------------------------'
                sh 'echo $ACCOUNT_KEY '
                sh 'echo ----------------------------------'
                sh 'echo $ACCOUNT_KEY > /home/creds/.cred'
                sh 'echo ----------------------------------'

                sh 'base64 -d /home/creds/.cred > /home/creds/.credentials'
                sh "terraform init"
                sh "terraform plan -out plan.txt"

            }
        }
    }
}
