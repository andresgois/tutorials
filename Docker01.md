

# Docker

## Seção 1: Básico
- O Docker é um software que redux a complexidade de aplicações
- Configuração de containers
- Velocidade na configuração de ambiente DEV
- Pouco tempo em manutenção
- Mais performático
- Docker tem duas versões
    - CE
        - Gratuita
    - EE
        - versão Paga
        - Suporte equipe docker
- Extensões para VS Code
    - Docker
- Testando Docker
    - docker run docker/whalesay cowsay Hello_world

## Seção 2: Trabalhando com Containers
- Container x Imagem
    - Imagem: Projeto que será executado
    - Container: Roda uma imagem
    - Criamos uma imagem e executamos através do container
- Onde encontra imagens
    - [Docker Hub](https://hub.docker.com/)
- Rodando um container
    - docker run ubuntu
    - docker run -it ubuntu
- Vê containers executando
    - docker ps
    - docker container ls
- Vê containers que já foram executando
    - docker ps -a
    - docker container ls -a
- Roda container com iteração
    - docker run -it node
- Roda container em backgroung
    - docker run nginx
    - docker run -d nginx
        - d: detached
- Expor uma porta
    - docker run -d -p 80:80 nginx
- Nome para o container
    - docker run -d -p 80:80 --name site-nginx nginx
- Para o container
    - docker stop <id_container> || <nome_container>
- Iniciar o container
    - docker start <id_container> || <nome_container>

#### Verificando logs
    - docker logs <id_container> || <id_container>
    - docker logs <id_container> || <id_container> -f
- Removendo containes
    - docker container rm <id_container> || <id_container> 
    - docker container rm <id_container> || <id_container> -f
        - f: força a exclusão, mesmo se estiver em execução

## Seção 3: Criando imagens e avançando em containers
- docker run -d -p 80:80 --name my-apache httpd
- Precisammos criar um arquivo chamado **Dockerfile**
- **FROM** imagem base
- **WORKDIR** diretório da aplicação
- **EXPOSE** porta da aplicação
- **COPY** quais arquivos precisam ser copiados
- Dockerfile

```
FROM node

WORKDIR /app

COPY package*.json

RUN npm install

COPY. .

EXPOSE 3000

CMD ["node", "app.js"]
```

- Build da imagem
    - docker build .
- Roda o container
    - docker run -d -p 3000:3000 id_container
- docker pull python
- **Comandos de ajuda**
    - docker run --help
- **Modo detached**
    - docker run -d -p 3000:3000 --name node1 node
    - docker run -d -p 3001:3000 --name node2 node
- **Nomeando imagem com TAG**
    - docker tag <nome>:<tag>
    - docker tag <id_imagem> node:app
- **Nomeando imagem no build**
    - docker build -t meuapp .
- **Iterativo**
    - docker start -it <container>
    - docker start -it nodeapp
- **Removendo imagem**
    - docker rmi <id_container>
    - docker rmi -f <id_container>
    - docker image rm <id_container>
- **Removendo imagens, containers, network**
    - docker system prune --help
    - docker system prune
- **Remove os container após a sua paralização**
    - docker run --rm <container>
    - docker run -d -p 3000:3000 --name node2 --rm node
- **Copiando arquivos entre containers**
    - docker cp container:/caminho/container/app.js ./pastaHost/
- **Verificando informações do processamento do container**
    - docker top some-nginx
    - **Informações de todos os containers que estão rodando**
    - docker stats
- **Verificar dados de um container**
    - docker inspect some-nginx
- **Enviar Imagem para o docker hub**
    - docker login
        - pede usuário e senha do docker hub
    - docker logout
        - encerra sessão no docker hub
    - criar repositório no docker hub
    - docker build -t nome/imagem .
    - *O nome do repositório tem que ser o mesmo da imagem*
    - docker push <nome/imagem>
    - **Para baixa essa mesma imagem**
        - docker pull nome/imagem
    - **Atualiza a imagem no docker hub**
        - *Fazer o build da imagem novamente*
        - docker build -t nome/imagem:1 .
        - docker push nome/imagem:1

## Seção 4: Introduzindo volumes aos nossos containers
- Forma prática para persistir dados.
- Todo dado criado em um container é salvo nele.
- Backups de forma mais simples.

```
FROM php:8-apache
WORKDIR /var/www/html/
COPY . .
EXPOSE 80
RUN chown -R www-data:www-data /var/www
```

- *Projeto em \ExemplosDocker\2_volumes*
- docker build -t phpmessages .
- docker run -d -p 80:80 --name phpmessages_container phpmessages
- **Para entrar no container
    - docker exec -it phpmessages_container /bin/bash
    - *as vezes pelo gitbash da erro de permissão*
    

- **Tipos de Volumes**
#### Anônimos (anonymous)
- Diretórios criados pela flag -v, porém com um nome aleatório.
- docker volume create data
- docker run -d -p 80:80 --name phpmessages_container --rm -v /data phpmessages

#### Nomeados (named)
- São volumes com nomes

#### Bind mounts
- Salvo na nossa máquina, sem gerenciamento do docker, informamos umdiretório pra esse fim.






## Seção 5: Conectando containers com Networks

## Seção 6: Introdução ao YAML

## Seção 7: Gerenciando múltiplos containers com Docker Compose

## Seção 8: Docker Swarm para orquestração

## Seção 9: Orquestração com Kubernetes

## Seção 10: ** EXTRA **: Comandos básicos de terminal

## Seção 11: Conclusão e próximos passos