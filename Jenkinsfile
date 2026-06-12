pipeline {
    agent any

    environment {
        IMAGE_NAME = 'app-web-devops'
        IMAGE_TAG = '1.0'
        CONTAINER_NAME = 'app-web-devops'
        APP_PORT = '8081'
        SONAR_HOST_URL = 'http://localhost:9000'
        SONAR_PROJECT_SETTINGS = 'ci/config/sonar-project.properties'
    }

    stages {
        stage('Carregar código') {
            steps {
                echo 'Carregando código no workspace do Jenkins...'
                sh '''
                    echo "Diretório atual:"
                    pwd

                    echo "Arquivos encontrados:"
                    ls -la
                '''
            }
        }

        stage('Teste automatizado') {
            steps {
                echo 'Executando teste automatizado da aplicação...'
                sh '''
                    chmod +x teste.sh
                    ./teste.sh
                '''
            }
        }

        stage('Análise SonarQube') {
            steps {
                echo 'Executando análise real com SonarQube Scanner...'

                withCredentials([string(credentialsId: 'sonar-token-app-web-devops', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        docker run --rm \
                          --network host \
                          -e SONAR_TOKEN="${SONAR_TOKEN}" \
                          -v "$PWD:/usr/src" \
                          -w /usr/src \
                          sonarsource/sonar-scanner-cli:latest \
                          sonar-scanner \
                          -Dproject.settings=${SONAR_PROJECT_SETTINGS} \
                          -Dsonar.host.url=${SONAR_HOST_URL}
                    '''
                }
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Construindo imagem Docker da aplicação...'
                sh '''
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Deploy em container') {
            steps {
                echo 'Publicando aplicação em container Nginx...'
                sh '''
                    docker rm -f ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:80 ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Validação do deploy') {
            steps {
                echo 'Validando se a aplicação está respondendo...'
                sh '''
                    docker ps
                    curl -I http://localhost:${APP_PORT}
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline executado com sucesso. Aplicação publicada em http://localhost:8081'
        }

        failure {
            echo 'Pipeline falhou. Verifique o Console Output do Jenkins para identificar o erro.'
        }
    }
}
