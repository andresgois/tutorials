
# Docker

## O que é Docker
- É uma containerização para criação de containers Linux

## Instalar docker no Linux
- [Referência](https://docs.docker.com/engine/install/ubuntu/)
- Vê versão do linux
    - cat /etc/\*realease\*
- curl -fsSL https://get.docker.com -o get-docker.sh
- sudo sh get-docker.sh
- docker version
- Status do Docker
    - systemctl status docker

## Baixando imagem
- [docker hub](https://hub.docker.com/)
- docker pull hello-world
- Vê todas as imagens
    - docker images
- Executa o container
    - docker run hello-world
- Exiber todos os container
    - docker ps -a
### Executando container
- docker pull ubuntu
- docker run ubuntu
- Executa o container por 10 segundos
    - docker run ubuntu sleep 10
- executa o container e já entra dentro dele
    - docker run -it ubuntu 

## Executando aplicações no container
- docker --help
- docker run -dti ubuntu
- docker exec -it id_container /bin/bash

### Excluir container
- docker container rm id_container

### Excluir Imagem
- docker image rm id_container

### Dando um nome ao container
- docker container run -dti --name my-linux ubuntu

### Copiando arquivo local para container
- Cria diretório dentro do container sem abrir o bash
    - docker exec my-linux mkdir /destino
- docker cp nome-arquivo.extensão my-linux:/destino

### Copiando arquivo container para local
- docker cp my-linux:/destino/nome-arquivo.extensão teste.txt

### Tags
- docker pull debian:9

## Criando container com MySql
- docker pull mysql
- docker run -e MYSQL_ROOT_PASSWORD=Senha123 --name mysql-A -d -p 3306:3306 mysql
    - **-e** declarando uma variável
    - **-d** em backgroud
    - **-p** definindo uma porta
    - **-name** nome para o container
- docker exec -it mysql-A bash
- mysql -u root -p --protocol=tcp
- **CREATE DATABASE aula;**
- **show databases;**
- docker inspect mysql-A
- mysql -u root -p --protocol=tcp

### Acessando container externamente
- Dentro do bash do container
    - ip a
    - copiar ip
    - cliente mysql 
        - workbench
        - sequeler
            - Menu hambugger
            - New connection
            - nome conexão
            - banco
            - host: ip do container
            - nome do banco
            - user
            - pass- connect
### Parando e reiniciando container
- docker container stop mysql-A
- docker container start mysql-A

### Banco com Volume
#### Mesmo excluido os containers, eles podem ser recuperados apenas apontando para o mesmo caminho onde os dados foram gravados
- docker run -e MYSQL_ROOT_PASSWORD=Senha123 --name mysql-A -d -p 3306:3306 --volume=/data:/var/lib/mysql mysql
- mysql -u root -p --protocol=tcp --port=3306

```
CREATE TABLE alunos (
    AlunoID int,
    Nome varchar(50),
    Sobrenome varchar(50),
    Endereco varchar(150),
    Cidade varchar(50)
);

INSERT INTO alunos (AlunoID, Nome, Sobrenome, Endereco, Cidade) 
VALUES 
(1, 'Carlos Alberto', 'da Silva', 'Av. que sobe e desce que ninguém conhece', 'Manaus');
```
### Volumes
#### Definição
- Basicamente, temos 3 tipos de volumes ou montagens para dados persistentes:
    * Bind mounts
        - As montagens **Bind** são basicamente apenas vincular um determinado diretório ou arquivo do host dentro do contêiner:
            - docker run -v /hostDir:/conteinerDir mysql
    * Named volumes
        - volumes nomeados são volumes que você cria manualmente com o comando:
            - docker volume create nome-do-volume
        - eles são criados em /var/lib/docker/ volumes podem ser referênciados apenas por seu nome.
        - digamos que você crie um volume chamado *mysql_data*, você pode apenas referênciá-lo como o comando:
            - docker run -v mysql_data:/conteinerDir mysql
    * Dockerfile volumes
        - Tipo de volume que são criados pela instrução **VOLUME**. Esses volumes também são criados em /var/lib/docker/ volumes, mas não tem um determinado nome. O volume é criado ao executar o contêiner e são úteis para salvar dados persistentes. O desenvovedor pode dizer onde estão os dados importantes e o que deve ser persistente.
        
#### bind mount 
- docker run -dti --mount type=bind,src=/opt/teste,dst=/teste debian
- docker run -dti --mount type=bind,src=/opt/teste,dst=/teste,ro debian

#### volumes
- docker volume create teste
- docker volume ls
- **/var/lib/docker/volumes/teste/_data**
- docker run -dti --mount type=volume,src=teste,dst=teste debian
- docker volume rm teste

### Tipos de mount na prática
#### MOUNT
- docker conteiner run --help
- docker run -dti --mount type=bind,src=/data/debian-A,dst=/data debian
    - src: caminho na sua máquina
    - dst: caminho no conteiner
- docker exec -ti nome_imagem bash
    - cd /data
    - touch file.txt
    - pronto, arquivo criado dentro do conteiner
    - se olhar na máquina host no caminho especificado, estará lá o arquivo que foi criado no conteiner
- criando arquivo somente leitura
    - docker run -dti --mount type=bind,src=/data/debian-A,dst=/data,ro debian

#### VOLUME
- docker volume ls
- docker volume create data-debian
- este arquivo é criado na pasta padrão do docker, em: /var/lib/docker/
- *Montar volume dentro do conteiner*
    - docker run -dti --name debian_container --mount type=volume,src=nome-do-volume,dst=/data debian
    - docker exec -ti debian_container bash
    - cd /data
    - touch file3.txt

# Subindo imagens
<details>
<summary> MongoDB </summary>

### MongoDB

#### Baixando imagem
> docker pull mongo:4.2-bionic

#### Executando o mongo
> docker container run --name mongodb -p 27017:27017 -d mongo:4.2-bionic --auth

#### Entrando no container
> docker container exec -it mongodb mongo admin
	
#### Comandos: 
> show dbs
> use local
> show collections
> use pagamentos
**--auth - ainda vai criar a autenticação pra ele**

#### Para criar usuário root: 
> db.createUser({ user: "root", pwd: "123456", roles: [{ role: "userAdminAnyDatabase", db: "admin" }]})
#### Autentica o usuário , 1° User, 2° senha
> db.auth("root","123456");
	
#### Para criar um usuário num banco qualquer:
> db.createUser({ user: "andre", pwd: "0516", roles: [ "readWrite", "dbAdmin" ] })

#### Sair do mongo 
> exit

#### Entrar pelo bash
> docker exec -it mongodb bash

#### Autentica com usuário root ou usuario específico
> mongo -u root -p   ||  mongo -u andre -p --authenticationDatabase pagamentos

#### Cria a collections e inserir os dados
> use pagamentos
> db.usuarios.insertOne({"nome": "Testando o mongo"});
> db.usuarios.find();
> db.usuarios.find().pretty();
	
</details>

<details>
<summary> PostGreSQL </summary>

### PostGreSQL

#### Download imagem
> docker pull postgres:alpine

#### Rodando imagem em background
> docker  run --name postdb -e POSTGRES_PASSWORD=123456 -d -p 5432:5432 postgres:13.3-alpine
	
#### Entrado no container
> docker exec -it postgres bash
#### Entrado diretamente no banco
> docker exec -it postdb psql -U postgres --password
> docker exec -it postdb psql -U postgres

#### Bash do postgres
> psql -U postgres

#### Lista os usuários
> \du

#### Cria um banco
> create database teste;

#### Lista os bancos
> \l

#### Entra no banco
> \c teste

#### Estrutura da tabela
> \d teste
	
#### arquivo de configuração do postgres 
> less ~/.zshrc

#### Outra forma de entrar no banco
> psql -h localhost -p 5432 -U postgres

#### Sair do banco
> \q

</details>

</details>

<details>
<summary> Others </summary>

</details>
