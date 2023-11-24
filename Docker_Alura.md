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



> Criando volume
- docker volume create meu-volume

> Com o volume criado, agora iremos executar um novo container vinculado ao volume. Para isso, execute o comando docker run -it -v meu-volume:/app ubuntu bash

> A rede host remove o isolamento entre o container e o sistema, enquanto a rede none remove a interface de rede.

## Comunicação de containers
- Agora iremos executar dois containers criados em uma mesma rede customizada, a fim de comunicar e trafegar informações entre uma aplicação e um banco de dados. Anteriormente, vimos que o papel da rede bridge é possibilitar a comunicação entre containers em um mesmo host. Chegou o momento de pôr isso em prática.

- Inicialmente, abra o terminal e execute o comando docker network ls. Caso ainda não tenha criado a rede minha-bridge, execute o comando docker network create --driver bridge minha-bridge.

- Em seguida, iremos executar o container responsável pelo banco de dados. Para isso, execute o comando `docker run -d --network minha-bridge --name meu-mongo mongo:4.4.6`. Repare que estamos usando a versão 4.4.6.

- Precisamos agora executar o container responsável pela aplicação que irá se comunicar com o banco de dados. Para isso, execute o comando docker run -d --network minha-bridge --name alurabooks -p 3000:3000 aluradocker/alura-books:1.0. Repare que utilizamos a flag -p para em seguida validar o funcionamento da aplicação através de nosso host.

- Em seu navegador, acesse a url localhost:3000 e veja que foi possível carregar a página da aplicação. Para que os dados sejam carregados e armazenados no banco, acesse localhost:3000/seed e, em seguida, recarregue a página localhost:3000. Veja que as informações agora estão sendo exibidas por conta da comunicação entre aplicação e banco de dados.

