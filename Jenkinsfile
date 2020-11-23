pipeline {
    agent any
    tools{
        terraform 'terraform'
    }
    parameters{
        choice(name: 'action', choices: ['plan','apply','destroy'])
    }

    stages {
        stage('Plan') {
            when{ expression { params.action != 'destroy'}}
                steps {
                    withAWS(credentials: 'aws_creds', region: 'eu-west-1'){
                        sh 'terraform init'
                        sh 'terraform plan -out plan'
                    }
                }
        }


        stage('Apply') {
            when{ expression { params.action == 'apply'}}
                steps {
                    withAWS(credentials: 'aws_creds', region: 'eu-west-1'){
                        sh 'terraform apply -auto-approve "plan"'
                    }
                }
        }

        stage('Destroy') {
            when{ expression { params.action == 'destroy'}}
                steps {
                    withAWS(credentials: 'aws_creds', region: 'eu-west-1'){
                        sh "terraform destroy -auto-approve"
                    }
                }
        }
    }
}