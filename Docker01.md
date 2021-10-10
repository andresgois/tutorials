

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


## Seção 4: Introduzindo volumes aos nossos containers

## Seção 5: Conectando containers com Networks

## Seção 6: Introdução ao YAML

## Seção 7: Gerenciando múltiplos containers com Docker Compose

## Seção 8: Docker Swarm para orquestração

## Seção 9: Orquestração com Kubernetes

## Seção 10: ** EXTRA **: Comandos básicos de terminal

## Seção 11: Conclusão e próximos passos