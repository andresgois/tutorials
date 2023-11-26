# Infraestrutura como código: preparando máquinas na AWS com Ansible e Terraform

- [Fundamentos da IaC](#anc1)
- [SSH, Git e servidor](#anc2)
- [Terraform e Ansible](#anc3)
- [Dependências com Ansible](#anc4)
- [Boas práticas, shell e novas tarefas](#anc5)

<a name="anc1"></a>

## Fundamentos da IaC

> A infraestrutura como um código, ou também chamada de IaC, é um jeito que nós temos de escrever e executar código para nós podermos definir, implantar, atualizar e gerenciar a infraestrutura. Uma característica muito importante do IaC é que você pode gerenciar servidores, banco de dados, redes, arquivos de log, configurações de aplicativos, documentação, testes automatizados, entre outras coisas, através de código.

### Preparando o ambiente
#### Ferramentas
- Nesse curso vamos instalar 3 ferramentas, o Terraform, o Ansible, que dependo do Python e a AWS CLI.

#### Windows
- No Windows podemos utilizar 3 métodos para instalar os programas necessários, podemos usar o WSL, a forma mais recomendada de se executar os programas dentro do windows, outra opção é se você já fez o curso "Windows Prompt: utilizando o CMD" e conhece o chocolatey para configurar o seu ambiente, se não, a instalação manual dos pacotes é possível.

#### WSL
- Utilizar o WSL é a forma mais recomendada de se utilizar os programas, para aprender mais sobre o WSL temos um artigo clicando aqui Após a instalação você pode seguir como se estivesse em um sistema Ubuntu.

#### Instalação manual
> Para instalar o Terraform:

- Basta ir até a página de download, selecionar se qual a versão a ser baixada, dando preferência para 64-bit (AMD64), extrair o arquivo e instalá-lo.

#### Para instalar o Python:

- Basta ir até a página de download, clicar em download python, e instalá-lo.

- Para instalar o Ansible, abra um Powershell como administrador e execute:
```
python -m pip install ansible
python -m pip install paramiko
```

- Nesse casso o executável ficara como ansible-community.exe ao invés de ansible

- Caso você ainda não tenha instalado a AWS CLI, basta ir a página da AWS CLI e seguir os procedimentos para o seu sistema operacional.

- Depois de instalado você pode configurar a AWS usando o comando aws configure no PowerShell onde será requisitado a chave secreta (secret key) que pode ser criada nessa pagina clicando em “criar chave de acesso” na aba “Chaves de acesso”. Uma vez dentro do processo de criação, selecione "Command Line Interface (CLI)" e marque a opção "Compreendo a recomendação acima e quero prosseguir para criar uma chave de acesso." Coloque uma descrição para a chave, como "cursos de IaC" e salve os codigos da "Chave de acesso" e da "Chave de acesso secreta" para poderem se utilizado no PowerShell.

#### Chocolatey
- Para instalar o Terraform:
```
choco install terraform
```
- Para instalar o Python:
```
choco install python
```
- Para instalar o Ansible:
```
python -m pip install --user ansible
python -m pip install --user paramiko
```

- Caso você ainda não tenha instalado a AWS CLI, basta ir a página da AWS CLI e seguir os procedimentos para o seu sistema operacional.

- Depois de instalado você pode configurar a AWS usando o comando aws configure no PowerShell onde será requisitado a chave secreta (secret key) que pode ser criada nessa pagina clicando em “criar chave de acesso” na aba “Chaves de acesso”. Uma vez dentro do processo de criação, selecione "Command Line Interface (CLI)" e marque a opção "Compreendo a recomendação acima e quero prosseguir para criar uma chave de acesso." Coloque uma descrição para a chave, como "cursos de IaC" e salve os codigos da "Chave de acesso" e da "Chave de acesso secreta" para poderem se utilizado no PowerShell.

#### Ubuntu
- Para instalar o Terraform no Ubuntu, utilize os comandos abaixo:
```
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

- Para instalar o Python no Ubuntu, utilize o comando abaixo:
```
sudo apt install python3
```
- Para instalar o Ansible no Ubuntu, utilize os comandos abaixo:
```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible
```
- Caso você ainda não tenha instalado a AWS CLI, basta ir a página da AWS CLI e seguir os procedimentos para o seu sistema operacional.

- Depois de instalado você pode configurar a AWS usando o comando aws configure no PowerShell onde será requisitado a chave secreta (secret key) que pode ser criada nessa pagina clicando em “criar chave de acesso” na aba “Chaves de acesso”. Uma vez dentro do processo de criação, selecione "Command Line Interface (CLI)" e marque a opção "Compreendo a recomendação acima e quero prosseguir para criar uma chave de acesso." Coloque uma descrição para a chave, como "cursos de IaC" e salve os codigos da "Chave de acesso" e da "Chave de acesso secreta" para poderem se utilizado no PowerShell.

### MacOS
- Para instalar o Terraform no MacOS, instale através do brew com o comando abaixo:
```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```
- Para instalar o Python no MacOS, instale através do brew com o comando abaixo:
```
brew install python3
```
- Para instalar o Ansibleno MacOS, instale através do brew com o comando abaixo:
```
brew install ansible
```

- Caso você ainda não tenha instalado a AWS CLI, basta ir a [página da AWS CLI](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html) e seguir os procedimentos para o seu sistema operacional.

- Depois de instalado você pode configurar a AWS usando o comando aws configure no PowerShell onde será requisitado a chave secreta (secret key) que pode ser criada [nessa pagina](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fus-east-1.console.aws.amazon.com%2Fiam%2Fhome%3Fregion%3Dus-east-1%26state%3DhashArgs%2523%252Fsecurity_credentials%26isauthcode%3Dtrue&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fiamv2&forceMobileApp=0&code_challenge=JCdpU7rE8M8QBUSihtYTvrtKgbaOsx859nljfzWhejU&code_challenge_method=SHA-256) clicando em “criar chave de acesso” na aba “Chaves de acesso”. Uma vez dentro do processo de criação, selecione "Command Line Interface (CLI)" e marque a opção "Compreendo a recomendação acima e quero prosseguir para criar uma chave de acesso." Coloque uma descrição para a chave, como "cursos de IaC" e salve os codigos da "Chave de acesso" e da "Chave de acesso secreta" para poderem se utilizado no PowerShell.

<a name="anc2"></a>

## SSH, Git e servidor

### Configurando o grupo de segurança
- Em fase de desenvolvimento da aplicação, é interessante deixarmos todas as portas abertas, assim temos acesso a todas as partes da máquina e também permitimos que requisições de qualquer lugar possam ser respondidas pela máquina, então vamos configurar o grupo de segurança para que a máquina possa responder a todas as requisições.

- Vamos começar indo para o painel da EC2 para acessar as configurações do grupo de segurança. Nós podemos acessar essas configurações através da seção “Recursos” e em seguida “Grupos de segurança”, ou através do menu lateral na seção “Rede e segurança” e em seguida “Security groups".

- Vamos selecionar o único item da lista. Ele tem um campo chamado “Nome do grupo de segurança” e esse campo deve ter o valor “default”. Na parte inferior da tela aparecerá uma aba com as configurações do grupo de segurança, nesta aba temos informações de “Regras de entrada” e “Regras de saída”, que são as configurações de conexão das máquinas que estão nesse grupo.

- Vamos em “Regras de entrada” e em seguida em “Edit inbound rules” (Editar regras de entrada). Na nova janela, podemos criar novas regras clicando em "Adicionar regra”. Lembrando que cada regra só contempla 1 endereço, então não podemos colocar todos em uma única regra. Assim que criarmos uma nova regra temos que selecionar o “Tipo”, que no nosso caso é “Todo o tráfego” e a “Origem” que é “anywhere-IPv4”, vamos fazer o mesmo processo de criar uma nova regra para o “anywhere-IPv6”.

- Agora podemos seguir o mesmo caminho para as “Regras de saída”. As diferenças são que ao invés de “Edit inbound rules” será “Edit outbound rules” e no lugar de “Origem” teremos “Destino”.

### Criando página simples no server
- Vamos acessar essa máquina Ubuntu e criar um arquivo ali dentro, então vou criar aqui via echo e vou criar um arquivo entre aspas. Eu vou colocar uma tag H1 só para ficarmos com esse texto bem destacado, e vou escrever assim, por exemplo, "olá mundo", o clássico olá mundo e você a nossa tag H1. echo "<hr>Ola mundo<h1.

- Fechando as aspas, eu quero que esse texto com esse h1 seja salvo em um arquivo chamado "index.html", então eu usei o sinal de maior, um espaço index.html, echo "<hr>Ola mundo<h1" > index.html. Dei um "Enter", não recebemos nenhuma mensagem. Se eu dou um ls aqui, nós podemos ver que existe um arquivo chamado "index.html", se eu dou um comando chamado cat index.html, nós vamos ver que dentro desse arquivo nós temos o conteúdo "olá mundo" entre h1. 

- Para nós visualizarmos essa página, temos que ter um servidor de http. No caso, o Linux que tem a busybox, que é um programa que já tem algumas funções e entre elas abrir um servidor http para nós. Vou começar aqui, busybox, nós queremos o http, e ele tem um "d" no final que é para nós identificarmos para busybox que é um servidor tipo http. busybox httpd

- Nós vamos passar uma tag - f e uma -p para falar qual porta queremos que esse servidor funcione, e no caso queremos que funcione na 8080. busybox httpd -f -p 8080. Esse comando já vai funcionar, só que quando nós fecharmos o nosso SSH ele vai parar o comando, então nós temos que fazer com que esse comando continue executando mesmo quando nós fecharmos, já com o servidor web queremos manter ele aberto o tempo todo.

- Nós vamos colocar "&" no final e antes do comando busybox, nós vamos colocar um outro comando, que é nohup. Esse nohup vai cuidar desse comando para nós para continuar executando. nohup busybox httpd -f -p 8080 &. Eu vou dar um "Enter" agora aqui e ele vai começar a execução.

> nohup busybox httpd -f -p 8080 &

- pegar o IP público da aplicação na AWS

- [Ignorar arquivos](https://www.toptal.com/developers/gitignore)


<a name="anc3"></a>

## Terraform e Ansible

### Executando comandos
- O Terraform pode criar arquivos e executar comandos dentro da instância que ele está criando e, para tal, precisamos apenas inserir algumas poucas linhas para permitir isso.

- Para mostrarmos para o terraform que queremos executar comandos, vamos criar uma linha dentro da declaração da instância com o conteúdo:

```
user_data = <<-EOF
                EOF
```
- Assim podemos colocar os nossos comandos dentro dos EOF. Esses comandos vão ser executados da mesma forma que um script seria executado, então é interessante começarmos com #!/bin/bash para identificar com qual tipo de console queremos executá-lo.

- Durante o vídeo, utilizamos esse método para ir até uma pasta, utilizando o comando cd e criamos um arquivo usando o comando echo e o operador >, e então executamos um servidor http usando o nohup busybox com o operador &.

- Então o user_data ficou com essas informações:
```
user_data = <<-EOF
                #!/bin/bash
                cd /home/ubuntu
                echo "<h1>Mensagem a ser mostrada</h1>" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
```

<a name="anc4"></a>

## Dependências com Ansible

### Exemplo de instalação do node via ansible
- Parâmetros necessários para instalar o NodeJS em uma máquina.
```
\\1
apt:
      pkg:
      - nodejs
      update_cache: yes
    become: yes
\\2
 apt:
      pkg:
      - nodejs
    become: yes
\\3
 apt:
      pkg:
      - nodejs
      update_cache: yes
```

### Criando um ambiente virtual
- O Ansible tem uma grande integração com o Python, então ele tem comandos prontos para certas ações, como instalar dependências com o pip e pip3, e criar ambientes virtuais, também conhecidos como “Virtual environments", ”Virtual envs” ou “Venv”, para instalar as dependências dentro deles, permitindo que a máquina tenha apenas o necessário na hora da execução e minimizando conflitos entre bibliotecas.

- Para criarmos uma dessas “venv” com o Ansible necessitamos de uma única linha, se formos instalar bibliotecas do Python, ou duas linhas para serem apenas criadas. Quando criamos uma “venv” e instalamos bibliotecas, essas bibliotecas são instaladas dentro desse ambiente virtualizado. Contudo, se não especificarmos uma “venv” durante a instalação, as bibliotecas serão instaladas no sistema como um todo.

- Para fazermos a criação, devemos adicionar o parâmetro virtualenv: dentro da tarefa pip: e a tarefa terá uma sintaxe parecida com:

```
- name: Instalando dependências com pip ( podemos trocar o nome da tarefa)
    pip:
      virtualenv: /home/ubuntu/tcc/venv
```
- Colocando o caminho onde queremos criar a “venv” e depois o parâmetro, e colocando outros parâmetros ou a - - - continuação do código em seguida, como:

```
- name: Instalando dependências com pip ( podemos trocar o nome da tarefa)
    pip:
      virtualenv: /home/ubuntu/tcc/venv
      name:
        - django
        - djangorestframework
        ...
```
- Com isso, o Ansible tentará iniciar a “venv” e, caso não encontre ela, criará uma.


<a name="anc5"></a>

## Boas práticas, shell e novas tarefas

### Utilizando o shell
- Algumas funções específicas de bibliotecas, como a django-admin, não estão presentes nativamente no Ansible, então podemos utilizar o parâmetro shell: para executar as funções que queremos.

- Para utilizarmos o shell: devemos criar uma nova tarefa e colocar todos os comandos que queremos executar dentro de aspas, simples ou duplas, ou de acentos graves, assim o Ansible consegue distinguir o que deve ser executado.

- Então a linha de comando pode ser escrita das seguintes formas:
```
- name: Iniciando o projeto
    shell: 'comando 1; comando 2; comando 3'
- name: Iniciando o projeto
    shell: 'comando 1'
    shell: 'comando 2'
```
- Com todos os comandos sendo escritos em uma única linha, e separados por “;”, eles são executado em sucessão, então a tarefa:
```
- name: Iniciando o projeto
    shell: 'cd /home/ubuntu; cat index.html'
```
- Começará indo até a pasta /home/ubuntu, e em seguida mostrará o conteúdo do index.html que está na pasta /home/ubuntu.

- Já se escrevermos o código em mais de uma linha, desta forma:
```
- name: Iniciando o projeto
    shell: 'cd /home/ubuntu'
    shell: 'cat index.html'
```

- Os comandos anteriores não interferem no novo, então o primeiro comando irá até a pasta /home/ubuntu, enquanto o segundo comando será executado em /, então devemos tomar cuidado com como escrevemos os comandos shell.


### Ignorando erros
- Durante a inicialização do projeto, feito através do comando django-admin startproject setup /home/ubuntu/tcc/ podemos encontrar um erro, e esse erro é sobre substituir arquivos já existentes. No caso do Django, a substituição não é realizada para se manter a segurança e certificar que os dados do projeto atual não serão perdidos. Contudo, isso impede o nosso playbook de continuar a sua execução.

- Para podermos continuar a execução nesse caso, podemos usar um outro parâmetro, o ignore_errors: yes. Esse parâmetro vai fazer com que o playbook continue independente do comando ter retornado OK, changed ou fail.

- Então, para o nosso playbook se tornar mais versátil e poder se executado quantas vezes quisermos, é interessante colocar esse novo parâmetro na tarefa “Iniciando o projeto”. Desse jeito, teríamos:

```
- name: Iniciando o projeto
    shell: '. /home/ubuntu/tcc/venv/bin/activate; django-admin startproject setup /home/ubuntu/tcc/'
    ignore_errors: yes
```
- Contudo, tome cuidado, pois diferentes bibliotecas ou programas podem ter características diferentes, substituindo o projeto atual, ou ignorando erros sérios que podem comprometer a integridade do projeto como um todo.

- Por exemplo, se colocássemos esse parâmetro e o django-admin não conseguisse iniciar o projeto, teríamos um erro mais para a frente, onde o Ansible não encontraria o arquivo de configurações para fazer as alterações necessárias, mostrando assim outro erro. Mas, sem a presença do primeiro erro, não saberíamos o que realmente está acontecendo.

- Então, o ato de ignorar erros pode, e deve, ser usado em algumas situações, mas sempre com muito cuidado!

### referências
- [Terraform](https://www.terraform.io/)