## Cria instância
- criar instância
- t2.micro
- ubuntu server 22.04LTS
- criar par de chaves para windows ppk, linux .pem

## Instalações opcional
### Install docker
- sudo apt-get remove docker docker-engine docker.io containerd runc
- sudo apt-get update
- sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
- curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
- echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
- sudo apt-get update
- sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

### Docker compose-compose 
- sudo apt-get update
- sudo apt-get install docker-compose-plugin

- chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

### Install yarn
- sudo npm i --global yarn 

## Criar usuário para acesso a instância
- sudo adduser app
	- senha
- permissão de root
	- sudo usermod -aG sudo app
- sudo su - app 
- mkdir .ssh
- chmod 700 .ssh/
- cd .ssh/
- touch authorized_keys
- chmod 600 authorized_keys
- nano authorized_keys
	- colocar chave pública da máquina local
- **Gerar em sua máquina uma chave pública**
	- ssh-keygen
	- Enter Enter Enter 
	- cat ~/.ssh/id_rsa.pub
	- copia a chave
- nano authorized_keys
	- cola a chave
	- :wq
#### Observação, Caso esteja usando a versão 22 do Linux na instância EC2
- Adicionar a seguinte linha ao arquivo 
```
  sudo nano /etc/ssh/sshd_config
```
- Na última linha coloque
```
PubkeyAcceptedKeyTypes=+ssh-rsa
```
  - CRTL + O para salvar
  - CRTL + X para sair

- sudo service ssh restart
### Acessar instância
- ssh app@ip_server
- sudo apt update
- curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
- sudo apt-get install -y nodejs

## Proxy reverso
> Instalar o nginx
- sudo apt install nginx
- Habilitar a porta 80 na AWS
- Entrar no security group da instancia
- Editar regras de entrada
- Adicionar HTTP | 80 | Anywhere
- Adicionar HTTPS | 443 | Anywhere
> Acessar configuração do NGINX
- cd /etc/nginx/sites/available
- default
```
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        location / {
          proxy_pass http://localhost:3000;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection 'upgrade';
          proxy_set_header Host $host;
          proxy_cache_bypass $http_upgrade;
    }
}
```
- Reiniciar o nginx
- sudo service nginx restart

## PM2
- [PM2](https://pm2.keymetrics.io/)
- sudo npm install pm2 -g
> Comandos
- pm2 stop crudjs_app
- pm2 restart crudjs_app
- pm2 delete crudjs_app
- pm2 list
- pm2 monit
- **pm2 start caminho_aplicacao --name crudjs_app**


### Configurar actions do GITHUB
- github.com
- Página Actions
> Para criar o WorkFlow
- set up a workflow yourself 

```
# This is a basic workflow to help you get started with Actions

name: CI

# Controls when the workflow will run
on:
  # Triggers the workflow on push or pull request events but only for the main branch
  push:
    branches: [ main ]
  #pull_request:
    #branches: [ main ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v2
      # Setup node: https://github.com/actions/setup-node
      - name: Setup Nodejs
        uses: actions/setup-node@v2
        with:
          node-version: 14.x

      - name: Install Dependecies
        run: yarn

      - name: Build
        run: yarn run build

      # Copia arquivos via SSH:  https://github.com/marketplace/actions/scp-files
      - uses: appleboy/scp-action@master
        with:
          host: ${{ secrets.SSH_HOST }}
          username: ${{ secrets.SSH_USER }}
          port: ${{ secrets.SSH_PORT }}
          key: ${{ secrets.SSH_KEY}}
          source: "., !node_modules"
          target: "~/app"

      - name: Update API
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.HOST }}
          username: ${{ secrets.USERNAME }}
          key: ${{ secrets.KEY }}
          port: ${{ secrets.PORT }}
          script: |
            cd ~/app
            npm i
            pm2 restart crudjs_app
```

- nível gratuito **2000 builds minuto no mês**

> SSH for GitHub Actions
[SSH for GitHub Actions](https://github.com/appleboy/ssh-action#setting-up-ssh-key)

> SSH for GitHub Actions
[SSH for GitHub Actions](https://github.com/appleboy/ssh-action#setting-up-ssh-key)

> Github Actions
[Actions](https://github.com/actions)

> Setup Node
[setup-node](https://github.com/actions/setup-node)

> Copia os arquivos via SSH
[scp-files](https://github.com/marketplace/actions/scp-files)

> Mais de um comando na action
[ssh-action](https://github.com/appleboy/ssh-action)


### Gerar Chaves pública e privada
- Gerar um ssh-keygen pelo **GITBASH** ou se estiver no Linux, pelo próprio terminal
- Digite no terminal para gerar a chave
  - ssh-keygen
- Nome para a chave 
  - **github_action**
  - Pode dar Enter até gerar a chave
- Copia a chave gerada github_action.pub

### Adicionar chave pública para instância EC2
- Salvar ela na instância EC2 no arquivo:
  - Se não existir a pasta, você cria uma
  - **Dar permissão reduzida para a pasta**
  - chmod 700 .ssh/
  - cd .ssh/
  - touch authorized_keys
  - chmod 600 authorized_keys
  - nano authorized_keys
  - copia a chave pública pra lá

### Criando Credenciais no Github
- Criar credenciais para que a Action do Github tenha acesso a instância da AWS
- **Credenciais**
- Settings > Secret Actions
- chaves a serem criadas

```
  SSH_HOST  = ip da aws
  SSH_KEY   = github_actions
  SSH_PORT  = 22
  SSH_USER  = app
```


### Criação de usuário para o docker
- sudo groupadd docker
- sudo usermod -aG docker $USER

### Subir apenas o serviço de banco no docker-compose
- docker-compose up -d database
- docker exec -it database_ignite /bin/bash




## RDS
- Database
  - RDS
    - Create Database
      - Standand create
      - Qual banco
      - Versão do banco
      - **Template**
      - Free Tier
      - **Settings**
      - Nome identificador
      - Senha
      - **DB instance size**
      - db.t2 micro
      - **Storange**
      - SSD
      - 20GB
      - Storange autoscalling (**no**) aumenta o tamanho do disco
      - **Conectivy**
      - VPC default
      - *Aditional configuration*
        - subnet group
        - Public accessible
        - YES   (Acesso externo) **OBS: liberar no firewall**
        - NO    (Apenas EC2)
      - **Authenticate**
      - Passoword
      - **Database options**
      - nome do banco
      - backup (**no**)
      - **Maintenance**
      - Enable auto minor version upgrade
  - Habilitar firewall para acesso externo ao banco
  - RDS
  - Database
  - Instância
  - Connectivity & security
    - security
    - VPC security gruop
    - Inbound rules
    - Edit inbound rules
    - Add rule
    - PostgreSQL | TCP | 5432 | Anywhere | 0.0.0.0/0 | Descrição




## Erro
Possíveis soluções para o problema de SSH Handshake
Criar um arquivo "authorized_keys2" e inserir a chave ssh pública lá dentro
touch ~/.ssh/authorized_keys2
Alterar as permissões do diretório .ssh para 700
chmod 700 ~/.ssh
Alterar as permissões do arquivo authorized_keys para 640
chmod 640 ~/.ssh/authorized_keys
ou

chmod 640 ~/.ssh/authorized_keys2
Algumas distribuições Linux podem possuir alguma incompatibilidade por conta do openssh, no caso do recente Ubuntu 22.04:

Adicionar a seguinte linha ao arquivo /etc/ssh/sshd_config da sua instância:
PubkeyAcceptedKeyTypes=+ssh-rsa
```
Algumas distribuições Linux podem possuir alguma incompatibilidade por conta do openssh, no caso do recente Ubuntu 22.04:
tinha que adicionar isso **PubkeyAcceptedKeyTypes=+ssh-rsa**
ao  arquivo /etc/ssh/sshd_config na instância
```

sudo nano /etc/ssh/sshd_config
Ao acessar o arquivo, vá ate o final dele e adicione a linha PubkeyAcceptedKeyTypes=+ssh-rsa

Após, reinicie o serviço sshd utilizando:

sudo systemctl restart sshd
Está solução foi a que funcionou para mim

Algumas observações:

Verifique se possui o nome incorreto em algum secret, não sendo o mesmo que está definido no arquivo YML do Github Actions

É recomendado gerar a chave SSH na sua máquina local, não no servidor remoto/instância do EC2

No secret de SSH_KEY, mantenha os headers da chave privada. No caso:

-----BEGIN OPENSSH PRIVATE KEY-----
<CHAVE_PRIVADA>
-----END OPENSSH PRIVATE KEY-----
Tentar copiar o conteúdo contido no arquivo da chave SSH diretamente, usando um editor de texto como o VSCode ao invés de copiar do terminal

Caso esteja um pouco confuso qual conteúdo de qual arquivo utilizar: No authorized_keys, coloque o conteúdo do arquivo .pub gerado, por exemplo github_actions.pub. No secret do Github Actions coloque o conteúdo do arquivo SEM a extensão .pub, por exemplo github_actions (não possui extensão).

Verifique se está inserindo o HOST correto nos secrets do Github Actions, já que o painel da EC2 possui diversos IPs. O correto é utilizar o "Endereço IPv4 público"


## References
- https://github.com/nodesource/distributions
- https://docs.docker.com/engine/install/ubuntu/
- https://docs.docker.com/compose/install/
- https://github.com/appleboy/ssh-action/issues/80
- https://github.com/appleboy/ssh-action/issues/157
- https://github.com/appleboy/ssh-action