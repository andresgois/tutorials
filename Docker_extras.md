# Docker

### Erro de permissão
```
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json": dial unix /var/run/docker.sock: connect: permission denied
```
- Cria grupo chamado docker e adiciona o usuário ativo
```
sudo usermod -aG docker $USER
```
- [Referência](https://docs.docker.com/engine/install/linux-postinstall/)

### Pause
- docker pause id_contaner
- docker unpause id_contaner

### Portas
- docker run -d -P dockersamples/static-site
- docker port id_contaner
- docker rm id_contaner --force
-           porta_host:porta_container
- docker run -d -p 8080:80 dockersamples/static-site

- Inspeciona imagem
    - docker inspect f589ccde7957
- Lista Camadas
    - docker history f589ccde7957