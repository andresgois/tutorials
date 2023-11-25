# Docker

## Criando imagens
> Podemos visualizar as camadas de uma imagem através do comando
- docker history id_imagem
- docker build -t <seu-nome-de-usuario-do-docker-hub>/app-node:1.0 .
```
FROM node:14
WORKDIR /app-node
ARG PORT_BUILD=6000
ENV POST=$PORT_BUILD # Estará dento do container
EXPOSE $PORT_BUILD
COPY . .
RUN npm install
ENTRYPOINT npm start
```

- A instrução **ARG** carrega variáveis apenas no momento de build da imagem, enquanto a instrução **ENV** carrega variáveis que serão utilizadas no container.

## Persistindo dados
> Pega apenas o ID da imagem
- docker images -aq

> Tamanho do conatiner
- docker ps -s

> Anteriormente entendemos que os bind mounts são capazes de persistir dados de containers através de um vínculo criado com a estrutura de pastas do nosso host. Porém, ainda precisamos fixar como criar um.
- docker run -–mount type=bind,source=/home/diretorio,target=/app nginx

> Já aprendemos sobre a possibilidade de usar bind mounts e volumes para persistir dados no ambiente Docker. Porém, com a utilização de volumes, temos uma vantagem em relação aos bind mounts.
- Volumes são gerenciados pelo Docker e independem da estrutura de pastas do sistema.

#### A primeira informação que podemos seguir de uma maneira, além da documentação, é utilizar os volumes. Existem três tipos principais.

- Um deles é a parte do **bind mount**, que é uma maneira com que podemos fazer um build entre o file system do nosso sistema operacional e o sistema de arquivos do nosso container. Então teremos uma ponte entre essas duas partes, que vai persistir essa informação no nosso host.

- Temos o **volume** efetivamente, que será gerenciado pelo Docker. Mas vamos entender tudo isso em mais detalhes. E tem o **tmpfs**, que é temporário. Mas vamos entender a utilidade dele também.

### bind mount
- docker run -it -v /home/andre/volume-docker:/app ubuntu bash
- docker run -it --mount type=bind,source=/home/andre/volume-docker,target=/app ubuntu bash

### volumes
> Criando volume
- docker volume create meu-volume
- docker run -it -v meu-volume:/app ubuntu bash
> Pasta onde fica os volumes criados no docker 
- sudo ls -la /var/lib/docker/volumes/meu-volume/_data
- docker run -it --mount source=meu-volume,target=/app ubuntu bash

### tmpfs
> Armazenamento temporário
- docker run -it --tmpfs=/app ubuntu bash


> Com o volume criado, agora iremos executar um novo container vinculado ao volume. Para isso, execute o comando docker run -it -v meu-volume:/app ubuntu bash

> A rede host remove o isolamento entre o container e o sistema, enquanto a rede none remove a interface de rede.

## Redes
### Comunicação de containers
> Redes do tipo **brigde** conseguem se comunicar

- Criando rede
- docker network create my-rede
- docker container run -d --name linux1 --network my-rede ubuntu
- docker inspect linux
```
"NetworkSettings": {
            "Bridge": "",
            "SandboxID": "45864067eae131cb7db00e2ff8ad17e056bba84b6a804a96e087fe5828e6bb29",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {},
            "SandboxKey": "/var/run/docker/netns/45864067eae1",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "",
            "Gateway": "",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "",
            "IPPrefixLen": 0,
            "IPv6Gateway": "",
            "MacAddress": "",
            "Networks": {
                "my-rede": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": [
                        "25887b433321"
                    ],
                    "NetworkID": "ca9f3b3505fcaa5a4715af0b7134c80d3c22a5c19ab2c44614d83f41f747971c",
                    "EndpointID": "",
                    "Gateway": "",
                    "IPAddress": "",
                    "IPPrefixLen": 0,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "",
                    "DriverOpts": null
                }
            }
        }

```

- docker container run -it --name linux1 --network my-rede ubuntu
- docker container run -d --name linux2 --network my-rede ubuntu sleep 1d
- entre no container linux1
    - docker exec -it linux1 bash
    - apt-get update
    - apt-get install iputils-ping -y
    - ping linux2
> Rede nano
- Não tem nenhum interface de rede associada
> Rede host
- Usa a mesma interface de rede do hospedeiro

## Conectando aplicação ao banco via linha de comando
- docker run -d --network minha-bridge --name meu-mongo mongo:4.4.6
- docker container run -d --name alurabooks --network my-rede -p 3000:3000 aluradocker/alura-books:1.0

- Agora iremos executar dois containers criados em uma mesma rede customizada, a fim de comunicar e trafegar informações entre uma aplicação e um banco de dados. Anteriormente, vimos que o papel da rede bridge é possibilitar a comunicação entre containers em um mesmo host. Chegou o momento de pôr isso em prática.

- Inicialmente, abra o terminal e execute o comando docker network ls. Caso ainda não tenha criado a rede minha-bridge, execute o comando docker network create --driver bridge minha-bridge.

- Em seguida, iremos executar o container responsável pelo banco de dados. Para isso, execute o comando `docker run -d --network minha-bridge --name meu-mongo mongo:4.4.6`. Repare que estamos usando a versão 4.4.6.

- Precisamos agora executar o container responsável pela aplicação que irá se comunicar com o banco de dados. Para isso, execute o comando docker run -d --network minha-bridge --name alurabooks -p 3000:3000 aluradocker/alura-books:1.0. Repare que utilizamos a flag -p para em seguida validar o funcionamento da aplicação através de nosso host.

- Em seu navegador, acesse a url localhost:3000 e veja que foi possível carregar a página da aplicação. Para que os dados sejam carregados e armazenados no banco, acesse localhost:3000/seed e, em seguida, recarregue a página localhost:3000. Veja que as informações agora estão sendo exibidas por conta da comunicação entre aplicação e banco de dados.

- [Página inicial](http://localhost:3000)
- [Página que popula os dados](http://localhost:3000/seed)

## Coordenando containers
- [Instalando o docker-compose](https://docs.docker.com/compose/install/linux/)
