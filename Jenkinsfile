pipeline {

  agent {
    label 'workstation'
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main', url: "https://github.com/Revanthsatyam/aws-schema-init-cont.git"
      }
    }

    stage('Build Image') {
      steps {
        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 058264090525.dkr.ecr.us-east-1.amazonaws.com"
        sh "docker build -t 058264090525.dkr.ecr.us-east-1.amazonaws.com/aws-schema-init-cont:${env.BUILD_NUMBER} ."
      }
    }

    stage('Image Push To ECR') {
      steps {
        sh "docker push 058264090525.dkr.ecr.us-east-1.amazonaws.com/aws-schema-init-cont:${env.BUILD_NUMBER}"
      }
    }

  }

  post {
    always {
      cleanWs()
    }
  }

}