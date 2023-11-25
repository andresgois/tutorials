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

<a name="anc5"></a>

## Boas práticas, shell e novas tarefas


### referências
- [Terraform](https://www.terraform.io/)