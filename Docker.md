
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

## Instalando Docker no Windows
- Power Shell como administrador
- Verifique se a Subsistema do Windows para linux está ativada
    - Painel de Controle
        - Programas e Recursos
            - Ativar ou desativar recursos do windows
- dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
- atualiza Windows
- dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
- [Baixe o arquivo](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
- pelo Power Shell, entre na pasta onde está o arquivo baixado
- Start-Process .\wsl_update_x64.msi
- wsl --set-default-version 2
    - Caso queira você pode entrar na loja do windows e baixar a versão do linux para roda dentro do windows
- Instalar o Docker Desktop Installer.exe
- Versão do Docker
    - docker --version
- Reinicie o PC
- caso de erro ao startar o Docker Desktop
- [Reinstale o wsl](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
#### Referência
- [Instalar o Docker no Windows](https://docs.docker.com/desktop/windows/install/#system-requirements-for-wsl-2-backend)
- [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)


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
- docker run -e MYSQL_ROOT_PASSWORD=123456 --name mysql-container -d -p 3306:3306 mysql
    - **-e** declarando uma variável
    - **-d** em backgroud
    - **-p** definindo uma porta
    - **-name** nome para o container
- docker exec -it mysql-container bin/bash
- mysql -u root -p --protocol=tcp
- **CREATE DATABASE aula;**
- **show databases;**
- docker inspect mysql-container
![Inspect do container](./imagens/docker/inspect_mysql_mounts.png)
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
- WINDOWS
    - docker run -e MYSQL_ROOT_PASSWORD=123456 --name mysql-container -d -p 3306:3306 -v=y:/tst-docker/container-mysql:/var/lib/mysql mysql:5.7
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
- Remove container em execução, sem a necessidade de parar e depois remover
    - docker rm -f id_container

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
- docker volume create centos-A
- docker run -dti --mount type=volume,src=centos-A,dst=/data --name centos-A centos
- docker inspect centos-A
    - verifica Mounts
- docker rm -f centos-A
- exclui todos os volumes que não estão em uso
    - docker volume prune

## Exemplos
### Usando Apache
- docker run  --name apache-A -d -p 80:80 --volume=/data/-apache-A:/usr/local/apache2/htdocs/ httpd
- Cria nessa pasta um arquivo index.html e coloca o código abaixo
```
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<title>Exemplo Apache</title>
</head>
<body>
<h1> OK !! Apache funcionando!!!!! </h1>
</body>
</html>
```
- docker run  --name php-A -d -p 8080:80 --volume=/data/php-A:/var/www/html php:7.4-apache
- Cria nessa pasta um arquivo index.php e coloca o código abaixo
```
<?php
phpinfo();
?>
```
> Mostra o status do container
    - docker stats nome-container

### Limitando memória e CPU
![Uso de memória](./imagens/docker/limit_memory.png)
- sair, aperte CRTL+C
- docker stats php-A
- Especifíca a quantidade de memória e a porcentagem da CPU que deve usar
    - docker update php-A -m 128M --cpus 0.2
- docker run --name ubuntu-C -dti -m 128M --cpus 0.2 ubuntu
- Entre no container, aplicação para teste de stress
    - apt update && apt install stress
    - stress --cpu 1 --vm-bytes 50m --vm 1 --vm-bytes 50m
        - **--vm** pacote
        - **--vm-bytes** volume de dados a ser enviado
##### docker info
- informações do servidor
##### docker container logs nome-container
- logs de determinado container
##### docker container top nome-container
- quais processos estão em execução no container

## REDES
- ip a
    - mostra as redes virtuais
- docker network --help
- docker network ls
- docker container inspect brigde
    - mostra quais containers estão associados a essa rede
- apt-get install iputils-ping
- docker network create minha-rede
- containers criados na mesma rede podem se comunicar
- docker run -dit --name Ubuntu-A --network minha-rede  ubuntu
- docker run -dit --name Ubuntu-B --network minha-rede  ubuntu



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
