pipeline {
    agent any
    tools { 
        maven 'localMaven 3.5.4' 
    }

stages{
        stage('Build'){
            steps {
                sh 'mvn clean package'
            }            
        
        post {
            success {
                echo 'Now Archiving...'
                archiveArtifacts artifacts: '**/target/*.war'
            }
        } 
    }
}
}