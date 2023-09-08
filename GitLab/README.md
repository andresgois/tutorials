# django-todolist

Simple todolist write in django for general use and pipeline automation..

  - Be kind with my baby

### Quick and free tip:

> With great power comes great responsibility


### Tech

Dillinger uses a number of open source projects to work properly:

* [Django] - Django makes it easier to build better Web apps more quickly and with less code.
* [Python-Venv] - The venv module provides support for creating lightweight “virtual environments” with their own site directories
* [MySQL] - MySQL is an Oracle-backed open source relational database management system (RDBMS) based on Structured Query Language (SQL).


### Installation

Install the dependencies and start the server.

```sh
$ cd django-todolist
$ pip install -r requirements.txt
$ python manage.py migrate # Running the migrations
$ python manage.py createsuperuser # Create a superuser
$ python manage.py runserver
```


License
----

GPL


# Gitlab CI e Docker: Pipeline de entrega contínua

## Comandos no GitLab
### Protejer Branch
- Settings > Repository > Protected Branches
    - Unprotect

### IMPORTANTE
- Identação
- O arquivo responsável por configurar todas as etapas da integração contínua é o .gitlab-ci.yml, que deve se criado na raiz do seu projeto, tendo como base uma indentação par. Caso essa regra seja quebrada, a integração não funcionará.
- Aponta projeto para o GitLab
    - git remote add gitlab git@gitlab.com:andresgois1/bytebank.git
    - git add --all
    - git commit -m "apontando versionamento"
    - git push gitlab master -f
- Podemos adicionar um novo endereço remoto, apontando diretamente para um projeto no gitlab. Caso precise manter o alias "origin" para o versionamento antigo, podemos criar um alias novo e manter os dois endereços ativos.

```
git remote add meualias https://gitlab.com/meuusuario/meuprojeto.git

docker-compose up --build

docker-compose up -d

docker-compose run web python manage.py makemigrations
docker-compose run web python manage.py migrate

 docker-compose run web python manage.py createsuperuser
```

- O comando docker pull é utilizado para baixar uma imagem de um repositório remoto, e o docker push utilizamos para enviar uma imagem ao repositório remoto. Para utilizarmos os dois comandos, precisamos sempre informar o nome da imagem docker que estamos manipulando.
```
docker pull minha-imagem:latest || true
docker push jnlucas/minha-imagem:latest
```

### Adicionando variaveis ao gitlab
- Settings > Ci/CD > Variables


## Criando um runner
- docker pull gitlab/gitlab-runner:latest
- docker run -d --name gitlab-runner --restart always -v ${pwd}/gitlab-runner/config/:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock gitlab/gitlab-runner:latest

- docker exec -it gitlab-runner bash
- Indicar ao gitlab para usar o runner na minha máquina
- Settings 
  - CI/CD 
    - RUNNERS
      - Registrar
      - Copia a chave
      - Entrar dentro do container
      - docker exec -it gitlab-runner bash
      - `gitlab-runner register`
      - a partir de agora ele fará algumas perguntas
        - Coloque o endereço remoro sugerido
          - https://gitlab.com
        - Coloque a chave
        - Coloque uma descrição: **bytebank-runner**
        - Coloque a Tab
        - Qual o tipo de executor
          - docker
          - Qual a imagem que você quer que ele se baseie
            - **andresgois/bytebank:latest**
        - registrado com sucesso 
      - Voltando em RUNNER, agora ele tem a sua runner lá
      - edite e coloque a tag, pois ela que faz a amaração com o runner
        - executor-tarefas

### Dentro do pipeline, devemos utilizar a palavra reservada “tags” e nela informar o nome da tag que configuramos dentro do gitlab-runner
```
tags:
  - executor-tarefas
```

### Dependência para stage
- Criando uma dependência entre tarefas no passo de testes. Podemos colocar essa dependência com o passo anterior, e dessa forma os testes só serão executados se o build estiver concluído com sucesso.

```
test-project:
  dependencies:
  - build-project
```

### Criação de runner-deploy
- agora será do tipo shell
- tag: **executor-deploy**

- Mostra os usuários do sistema: `cat /etc/passwd`
- Dê um `su gitlab-runner` dentro do conteiner do último runner criado.
- `ssh-keygen`
- copia a chave pública para colocar na máquina destino
  - entre no diretório que foi criado a chave ssh
  - `/home/gitlab-runner/.ssh/id_rsa`
  - Dê um cat:  `cat id_rsa.pub`
  - copia o conteúdo
  - saia do container
  - entre na pasta .ssh do destino
  - se não tiver um arquivo chamado `authorized_keys` crie
  - cole a chave pública do container nele
- Fazendo isso o usuário do conteiner **gitlab-runner** tem acesso a máquina local via ssh


### Caso de erro de:

```
ssh: connect to host 192.168.x.x port 22: Connection refused
```
#### Verifique se não é bloqueio no firewall
- Por padrão o Firewall do Linux fica ativo e bloqueia essas portas. Para verificar se o seu FireWall esta ativo execute o comando a baixo como root.

```
ufw status verbose
```

Caso seu FireWall esteja ativo, basta executar o comando a baixo para liberar a porta SSH "22"
```
sudo ufw allow ssh
```

- No meu caso como utilizo meu ambiente apensa para estudos em uma maquina virtual, eu desativei o FireWall Se esse também for seu caso basta executar o comando a baixo para desativar o FireWall.
```
sudo ufw disable
```
#### verifique se o SSH está instalado
```
systemctl -l --type service --all|grep ssh

sudo systemctl start ssh
```

- Se não encontrar nada, você pode instalar
```
sudo apt-get remove --purge openssh-server
sudo apt-get update
sudo apt-get install openssh-server
```

- Para realizarmos um deploy da aplicação após a execução dos testes unitários, precisaremos criar mais um passo dentro da pipeline que garanta tal tarefa. Porém, para que esse passo funcione, precisamos garantir acesso ao servidor remoto, para que a entrega do software aconteça nesse ambiente. Como podemos garantir acesso ao servidor remoto para que o deploy aconteça?
  - Criando um par de chaves (pública e privada) no runner com o comando “ssh-keygen”, e em seguida disponibilizamos a chave pública no servidor de homologação.


- mysql -h localhost -u devops_dev -p
```
insert into auth_user (password, username,first_name,last_name,email,is_superuser,is_staff, is_active,date_joined) values ('123','andre','andre','gois','andre@email.com',1,1,1,now());
```

## Slack para notificação
- Crie uma conta no Slack
- Crie um workspace
- Clique no nome do seu workspace
  - Configuração e administração
    - Gerenciar Apps
      - Na aba superior clique em `Desenvolver`
        - Em Messaging
          - Using Webhooks
            - Criar app
    - Volte para a tela do apps e selecione o app criado
    - Vá em Incoming Webhooks e ative seu hook
    - Vá em Install to workspace
    - Escola o canel e clique em permitir

> Adicionando a tarefa a palavra reservada “when” ao job e definindo “on_failure” como parâmetro.
```
notificacao-falhas:
  stage: notificacao
  tags:
  - executor-deploy
  when: on_failure
  script:
  - echo sh notificacaoFalha.sh
```