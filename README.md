# app-web-devops

Aplicação web estática (HTML, CSS e JavaScript puro) publicada de forma automatizada por meio de uma esteira DevOps utilizando Git, Jenkins, SonarQube, Docker e Nginx.

---

## 1. Descrição breve

O **app-web-devops** é um laboratório prático de DevOps que demonstra, de ponta a ponta, o ciclo de integração e entrega contínua (CI/CD) de uma aplicação web simples. A partir de um código-fonte versionado no Git, o Jenkins executa testes automatizados, realiza a análise estática de qualidade no SonarQube, constrói uma imagem Docker e publica a aplicação em um container Nginx acessível pelo navegador.

A aplicação em si é propositalmente simples para que o foco do estudo permaneça no **fluxo DevOps**, e não na complexidade do software.

---

## 2. Objetivo do laboratório

O objetivo deste laboratório é demonstrar, de maneira didática e reproduzível, como integrar as principais ferramentas de uma esteira DevOps moderna:

- versionamento de código com **Git**;
- automação de pipeline com **Jenkins**;
- testes automatizados via script de validação;
- análise estática de qualidade e segurança com **SonarQube**;
- empacotamento da aplicação com **Docker**;
- publicação (deploy) em container **Nginx**;
- validação do deploy e acesso pelo navegador.

Ao final, o estudante terá um ambiente completo onde uma alteração de código pode percorrer todas as etapas até virar uma aplicação publicada automaticamente.

---

## 3. Fluxo DevOps demonstrado

```text
Aplicação HTML/CSS/JavaScript
        ↓
       Git
        ↓
     Jenkins
        ↓
 Teste automatizado
        ↓
 Análise SonarQube
        ↓
   Docker Build
        ↓
Deploy em container Nginx
        ↓
 Acesso pelo navegador
```

Cada etapa do fluxo é representada por uma *stage* do pipeline declarativo presente no `Jenkinsfile`.

---

## 4. Sobre a aplicação

A aplicação web estática possui:

- uma tela inicial com o título **"Aplicação DevOps"**;
- a descrição: *"Aplicação simples publicada por pipeline Jenkins."*;
- um botão de estilo **brutalista** com o texto **"Powered By GPT-Omni"**;
- uma **animação de loading** com ampulheta ao clicar no botão;
- a mensagem final: **"Pipeline DevOps funcionando!"**;
- deploy em container **Nginx** na porta `8081`.

---

## 5. Tecnologias utilizadas

| Categoria            | Tecnologia                         |
| -------------------- | ---------------------------------- |
| Front-end            | HTML, CSS, JavaScript puro         |
| Versionamento        | Git / GitHub                       |
| Automação (CI/CD)    | Jenkins (Pipeline declarativo)     |
| Qualidade de código  | SonarQube (Community)              |
| Containerização      | Docker                             |
| Servidor web         | Nginx                              |
| Sistema operacional  | Ubuntu / WSL / VM Linux            |
| Runtime do Jenkins   | Java 21                            |

---

## 6. Estrutura do projeto

```text
app-web-devops/
├── ci/
│   └── config/
│       └── sonar-project.properties
├── Dockerfile
├── Jenkinsfile
├── index.html
├── script.js
├── style.css
├── teste.sh
├── .gitignore
└── README.md
```

Função de cada arquivo:

- **`index.html`**: estrutura (HTML) da página da aplicação.
- **`style.css`**: estilos visuais, incluindo o botão brutalista e a animação de loading.
- **`script.js`**: lógica de clique do botão, exibição do loading e da mensagem de resultado.
- **`teste.sh`**: teste automatizado simples que valida a existência dos arquivos obrigatórios do projeto.
- **`Dockerfile`**: receita da imagem Nginx usada para publicar a aplicação.
- **`Jenkinsfile`**: pipeline Jenkins declarativo com todas as etapas do fluxo DevOps.
- **`ci/config/sonar-project.properties`**: configuração da análise estática no SonarQube.
- **`.gitignore`**: lista de arquivos e diretórios ignorados pelo Git.

---

## 7. Pré-requisitos

Para reproduzir o laboratório, recomenda-se ter instalado:

- **Git**
- **Docker**
- **Docker Compose** (se necessário)
- **Jenkins**
- **SonarQube**
- **Java 21** (requisito do Jenkins)
- **Ubuntu, WSL ou VM Linux**

> **Para rodar apenas a aplicação** com Docker, basta ter **Git** e **Docker** instalados.
>
> **Para executar o pipeline completo** (testes, análise e deploy automatizado), é necessário ter **Jenkins** e **SonarQube** configurados e em execução.

---

## 8. Como clonar o projeto

```bash
git clone https://github.com/r2WillDev/app-web-devops.git
cd app-web-devops
```

Repositório do projeto:

```text
https://github.com/r2WillDev/app-web-devops
```

---

## 9. Como rodar localmente com Docker

Execute os comandos a partir da raiz do projeto:

```bash
docker build -t app-web-devops:1.0 .
docker rm -f app-web-devops || true
docker run -d --name app-web-devops -p 8081:80 app-web-devops:1.0
```

O que cada comando faz:

- `docker build -t app-web-devops:1.0 .` — constrói a imagem Docker a partir do `Dockerfile`, atribuindo a ela o nome `app-web-devops` e a tag `1.0`.
- `docker rm -f app-web-devops || true` — remove um container anterior com o mesmo nome, se existir; o `|| true` evita que o comando falhe caso não haja container a remover.
- `docker run -d --name app-web-devops -p 8081:80 app-web-devops:1.0` — sobe o container em segundo plano (`-d`), mapeando a porta `8081` do host para a porta `80` do Nginx dentro do container.

Validação:

```bash
docker ps
curl -I http://localhost:8081
```

Resultado esperado do `curl`:

```text
HTTP/1.1 200 OK
```

A aplicação fica disponível em:

```text
http://localhost:8081
```

---

## 10. Como acessar a aplicação

Após o container estar em execução, abra o navegador em:

```text
http://localhost:8081
```

Caso esteja executando em uma VM e acessando de outra máquina, substitua `localhost` pelo IP da VM:

```text
http://IP_DA_VM:8081
```

---

## 11. Como executar o teste automatizado

```bash
chmod +x teste.sh
./teste.sh
```

O `teste.sh` verifica a existência dos arquivos principais do projeto:

- `index.html`
- `style.css`
- `script.js`
- `Dockerfile`
- `Jenkinsfile`

Interpretação do resultado:

- **`exit 0`** → todos os arquivos foram encontrados (**sucesso**).
- **`exit 1`** → algum arquivo obrigatório está faltando (**falha**).

Esse mesmo script é reutilizado dentro do pipeline Jenkins na etapa de teste automatizado.

---

## 12. Como rodar em uma VM Ubuntu

Esta seção descreve a execução do laboratório em uma máquina virtual com Ubuntu.

**1. Instalar o Git:**

```bash
sudo apt update
sudo apt install -y git
```

**2. Instalar o Docker:**

```bash
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
newgrp docker
```

**3. Clonar o projeto:**

```bash
git clone https://github.com/r2WillDev/app-web-devops.git
cd app-web-devops
```

**4. Fazer o build e o deploy:**

```bash
docker build -t app-web-devops:1.0 .
docker rm -f app-web-devops || true
docker run -d --name app-web-devops -p 8081:80 app-web-devops:1.0
```

**5. Liberar o firewall (se necessário):**

```bash
sudo ufw allow 8081
sudo ufw status
```

**6. Descobrir o IP da VM:**

```bash
ip a
```

Com o IP em mãos, a aplicação pode ser acessada de outra máquina por:

```text
http://IP_DA_VM:8081
```

---

## 13. Jenkins

O projeto possui um `Jenkinsfile` **declarativo** com as seguintes *stages*:

- **Carregar código** — obtém o código-fonte a partir do Git.
- **Teste automatizado** — executa o `teste.sh`.
- **Análise SonarQube** — roda o scanner de análise estática.
- **Docker Build** — constrói a imagem da aplicação.
- **Deploy em container** — sobe a aplicação no Nginx.
- **Validação do deploy** — confirma que a aplicação respondeu corretamente.

De forma resumida, o pipeline executa comandos equivalentes a:

```bash
./teste.sh
docker run sonarsource/sonar-scanner-cli
docker build -t app-web-devops:1.0 .
docker rm -f app-web-devops || true
docker run -d --name app-web-devops -p 8081:80 app-web-devops:1.0
curl -I http://localhost:8081
```

---

## 14. Configuração do Jenkins

Passo a passo para criar o pipeline na interface do Jenkins:

1. Acessar o Jenkins:

   ```text
   http://localhost:8080
   ```

   ou, em uma VM:

   ```text
   http://IP_DA_VM:8080
   ```

2. Clicar em **"Novo Item"**.
3. Nomear o item como:

   ```text
   pipeline-app-devops
   ```

4. Escolher o tipo **"Pipeline"**.
5. Em *Pipeline*, selecionar **"Pipeline script from SCM"**.
6. Em *SCM*, escolher **Git**.
7. Informar a URL do repositório:

   ```text
   https://github.com/r2WillDev/app-web-devops.git
   ```

8. Definir o branch:

   ```text
   */master
   ```

9. Definir o *Script Path*:

   ```text
   Jenkinsfile
   ```

10. Salvar e clicar em **"Build Now"**.

### Permissão do Jenkins para usar Docker

Quando o Jenkins está instalado **diretamente no Ubuntu** (não em container), o usuário `jenkins` precisa de permissão para usar o Docker:

```bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

Validação:

```bash
sudo -H -u jenkins docker ps
```

Se esse comando funcionar e listar os containers, o Jenkins já consegue executar `docker build`, `docker run` e `docker ps` durante o pipeline.

---

## 15. SonarQube

Suba o SonarQube em um container Docker:

```bash
docker rm -f sonarqube-devops || true
docker run -d \
  --name sonarqube-devops \
  -p 9000:9000 \
  sonarqube:community
```

Validação:

```bash
docker ps
curl -I http://localhost:9000
```

Acesso pelo navegador:

```text
http://localhost:9000
```

Login inicial padrão:

```text
Usuário: admin
Senha: admin
```

> No primeiro acesso, o SonarQube **exige a troca da senha** padrão. Defina uma senha segura antes de prosseguir.

### Projeto no SonarQube

Crie um projeto no SonarQube com os seguintes dados:

```text
Project key: app-web-devops
Project name: app-web-devops
```

O arquivo `ci/config/sonar-project.properties` contém a configuração da análise:

```properties
sonar.projectKey=app-web-devops
sonar.projectName=app-web-devops
sonar.projectVersion=1.0

sonar.sources=.
sonar.exclusions=**/.git/**,**/node_modules/**,**/ci/**

sonar.sourceEncoding=UTF-8
```

### Token do SonarQube no Jenkins

O token de autenticação do SonarQube **não deve ser salvo no Git**. Ele precisa ser cadastrado no Jenkins como uma credencial:

```text
Kind: Secret text
ID: sonar-token-app-web-devops
```

O `Jenkinsfile` referencia esse **ID** para executar a análise de forma segura, sem expor o token no código.

> **Observações de segurança sobre o token:**
> - nunca versionar tokens no repositório;
> - nunca colocar tokens diretamente no `Jenkinsfile`;
> - usar sempre as *Credentials* do Jenkins;
> - revogar imediatamente qualquer token exposto acidentalmente.

---

## 16. Como executar o pipeline Jenkins

Com o item `pipeline-app-devops` já criado e configurado:

1. Acesse o pipeline na interface do Jenkins.
2. Clique em **"Build Now"**.
3. Acompanhe a execução pelo **Stage View** ou pelo **Console Output**.
4. Verifique se todas as *stages* foram concluídas com sucesso.

Ao final, o resultado esperado é:

```text
Finished: SUCCESS
```

---

## 17. Portas utilizadas

| Serviço   | Porta | URL                   |
| --------- | ----: | --------------------- |
| Jenkins   |  8080 | http://localhost:8080 |
| Aplicação |  8081 | http://localhost:8081 |
| SonarQube |  9000 | http://localhost:9000 |

> Troque `localhost` pelo IP da VM quando acessar de outra máquina.

---

## 18. Comandos úteis

```bash
git status
git log --oneline
docker ps
docker images
docker logs app-web-devops
docker logs sonarqube-devops
docker rm -f app-web-devops
docker start sonarqube-devops
sudo systemctl status jenkins
sudo systemctl restart jenkins
curl -I http://localhost:8081
curl -I http://localhost:9000
```

---

## 19. Possíveis problemas e soluções

**1. Docker não instalado**

```text
docker: command not found
```

Solução:

```bash
sudo apt update
sudo apt install -y docker.io
```

**2. Permissão negada no Docker**

```text
permission denied while trying to connect to the Docker daemon socket
```

Solução (usuário comum):

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Solução (Jenkins):

```bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

**3. Porta 8081 ocupada**

```bash
docker rm -f app-web-devops
sudo ss -ltnp | grep 8081
```

**4. SonarQube não abre**

```bash
docker logs -f sonarqube-devops
```

> O SonarQube pode levar alguns minutos para iniciar completamente. Aguarde os logs indicarem que o serviço está *up*.

**5. Jenkins falha na etapa do SonarQube por causa do token**

Verifique se a credencial existe no Jenkins com o ID exato:

```text
sonar-token-app-web-devops
```

**6. Aplicação não abre**

```bash
docker ps
curl -I http://localhost:8081
```

---

## 20. Resultado esperado

Ao final do laboratório, o usuário deve ter:

- a aplicação rodando em um container **Nginx**;
- acesso pelo navegador em `http://localhost:8081`;
- o pipeline **Jenkins** executando com sucesso;
- a análise aparecendo no painel do **SonarQube**;
- o **deploy automatizado** funcionando de ponta a ponta.

Exemplo de saída esperada no Jenkins:

```text
Finished: SUCCESS
```

Exemplo de saída esperada no `curl`:

```text
HTTP/1.1 200 OK
```

---

## 21. Observações de segurança

- Nunca versione **tokens, senhas ou segredos** no repositório.
- Utilize sempre as **Credentials do Jenkins** para armazenar dados sensíveis.
- Troque as **senhas padrão** (como a do SonarQube) no primeiro acesso.
- **Revogue imediatamente** qualquer token ou credencial exposto acidentalmente.
- Em ambientes de VM, libere no firewall **apenas as portas necessárias** (`8080`, `8081`, `9000`).
- Este projeto é um **laboratório educacional**; revise as configurações antes de utilizá-lo em qualquer ambiente de produção.

---

## 22. Autor

```text
Desenvolvido por Arthur Willyams.
Projeto criado como laboratório prático de DevOps com Git, Jenkins, SonarQube, Docker e Nginx.
```
