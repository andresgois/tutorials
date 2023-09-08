# Jenkins e Docker: Pipeline de entrega continua

- SonarQube
- Jenkins
- Pipeline
- Docker
- Slack
- CI/CD

![PIPELINE](./asserts/pipeline.png)

![CI/CD](./asserts/cicd.png)

## Vagrantfile
- config.vm.box 
    - Qual S.O vai usar
- config.disksize.size
    - Quanto de disco vai usar
- config.vm.network
    - Mapeamento das portas
- ip
    - Que será utilizado em quase tudo
- vb.memory
    - Quanto de memória vai usar

### Comandos vagrant
- sudo apt-get install virtualbox
- VBoxManage --version
- sudo apt install vagrant
- vagrant -h


### Configurando o ambiente e conectando a máquina virtual
```
# Configurando o ambiente e conectando máquina virtual:
    # Máquina virtual com o vagrant
    # Requisitos: http://vagrantup.com e https://www.virtualbox.org/
        # Baixar e descompactar o arquivo 1110-aula-inicial.zip
        # Entendendo o Vagranfile
        # Subindo o ambiente virtualizado
            vagrant plugin install vagrant-disksize
            vagrant up
            vagrant ssh
                ps -ef | grep -i mysql # Verificando se o MySQL esta rodando
                mysql -u devops -p # Senha mestre; show databases
                mysql -u devops_dev -p # Senha mestre; show databases
                # Instalando o Jenkins
                    cd /vagrant/scripts
                # Visualizar o conteudo do arquivo de instalacao do jenkins
                    sudo ./jenkins.sh

                # Acessar:  192.168.33.10:8080
                    sudo cat /var/lib/jenkins/secrets/initialAdminPassword

                # Credenciais
                    Nome de usuário: alura
                    Senha: mestre123
                    Nome completo: Jenkins Alura
                    Email: aluno@alura.com.br

                # Reload nas permissoes do docker
                    sudo usermod -aG docker $USER
                    sudo usermod -aG docker jenkins
                    exit
            vagrant reload
```