pipeline{
    agent any
    stages{
        stage("CheckOut"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'Ubuntu', url: 'git@github.com:lsj980Ya/web_demo.git']])
            }
        }
        stage("Depoly"){
            steps{
                docker stop web
                docker rm web
                docker rmi web
                docker build -t web .     
                docker run -it --name web -p 80:80 web  
            }
        }
    }
}