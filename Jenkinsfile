pipeline {
   agent any

   environment {
     // You must set the following environment variables
     // ORGANIZATION_NAME
     // YOUR_DOCKERHUB_USERNAME (it doesn't matter if you don't have one)

     SERVICE_NAME = "fleetman-api-gateway"
     REPOSITORY_TAG="${YOUR_DOCKERHUB_USERNAME}/${DOCKER_PROJECT_NAME}-${SERVICE_NAME}:${BUILD_ID}"
   }

   stages {
      stage('Preparation') {
         steps {
            cleanWs()
            git credentialsId: 'GitHub', url: "https://github.com/${ORGANIZATION_NAME}/${SERVICE_NAME}"
         }
      }
      stage('Build') {
         steps {
            sh '''mvn clean package'''
         }
      }
      
      stage('SonarQube') {
         steps {
            //sh '''mvn sonar:sonar Dsonar.projectKey=api-gateway -Dsonar.host.url=http://sonarqube.eqslearning.com:9000 -Dsonar.login=6048d8ddd7bca6b0eb9051d5e899ae8ab07f0d45'''
            sh 'echo $HOSTNAME'
         }
      }
      stage('Build Image') {
         steps {
           sh 'scp -r ${WORKSPACE} jenkins@${DOCKER_HOST_IP}:/home/jenkins/docker/${BUILD_ID}'
           sh 'ssh jenkins@${DOCKER_HOST_IP} docker image build -t ${SERVICE_NAME}:${BUILD_ID} /home/jenkins/docker/${BUILD_ID}'
           sh 'ssh jenkins@${DOCKER_HOST_IP} docker image ls'
           
         }
      }
      
      stage('Push Image') {
         steps {
           sh 'ssh jenkins@${DOCKER_HOST_IP} docker tag ${SERVICE_NAME}:${BUILD_ID} ${DOCKERHUB_URL}/${DOCKER_PROJECT_NAME}/${SERVICE_NAME}:${BUILD_ID}'
           sh 'ssh jenkins@${DOCKER_HOST_IP} docker push ${DOCKERHUB_URL}/${DOCKER_PROJECT_NAME}/${SERVICE_NAME}:${BUILD_ID}'
         }
      }
      stage('Deploy to Cluster') {
          steps {
                    sh 'echo "Deploy to production is in pipeline'
          }
      }
   }
}
