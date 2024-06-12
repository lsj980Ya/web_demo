pipeline{
    agent any
    parameters {
        string name: '版本号'
        choice choices: ['不更新', '测试更新', '生产更新'], name: '更新选择'
    }
    stages{
        stage("CheckOut"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'Ubuntu', url: 'git@github.com:lsj980Ya/web_demo.git']])
            }
        }
        stage("Depoly"){
            steps{
                script {
                    // 检查容器是否存在
                    def containerName = 'web'
                    def containerExists = sh (
                        script: "docker ps -a -q -f name=${containerName}",
                        returnStdout: true
                    ).trim()

                    if (containerExists) {
                        // 停止容器
                        sh "docker stop ${containerName}"
                        // 移除容器
                        sh "docker rm ${containerName}"
                        echo "Container ${containerName} stopped and removed."
                    }

                    // 检查镜像是否存在
                    def imageName = 'web'
                    def imageExists = sh (
                        script: "docker images -q ${imageName}",
                        returnStdout: true
                    ).trim()

                    if (imageExists) {
                        // 移除镜像
                        sh "docker rmi ${imageName}"
                        echo "Image ${imageName} removed."
                    }
                }

                sh """
                docker build -t web .     
                docker run -itd --name web -p 80:80 web  
                """
            }
        }
    }
}