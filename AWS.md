# AWS

## CRIAR CONTA
- https://portal.aws.amazon.com/billing/signup
- email
- senha
- nome conta

### Informações de contato
- Pessoal
- Número de telefone

### Pagamento
- Cartão
- Data validade
- Informações em geral do  cartão
- Verificação

### Selecione o plano de acesso
- Função
- Interesse

#### Faça login no console

### Console
#### Navbar
- Região
	- Regiões disponiveis para minha conta
	- Preços mudam de acordo com a região
- Suporte
- Serviços

## MODELO FREE TIER
- https://aws.amazon.com/pt/free/
> Isso para uma Instância
- Amazon EC2
	- 750 horas
	- Linux
	- RedHat
- Amazon S3
	- 5GB
	- 20.000 GET
	- 2.000 PUT
 
### MONITORAR CUSTOS
- No console
  - My Biling Dashboard
    - Monitor your estimated changes
	- Enabled Now
	   - Receive Free Tier Usage Alerts
		- manda uma email quando estiver perto de atingir o limite
	   - Receive Billing Alerts
		- Alerta quando estiver estourando
		- Clicar em 
			- Mananger biling alerts
			- Ferramenta: Clound watch
			- Create a biling alarm
			- valor se exceder e email
			- confirmar email

### Calcular gastos
- https://calculator.s3.amazonaws.com/index.html
- Escolha a região
- Escolha o serviço

### Suporte
- https://aws.amazon.com/pt/premiumsupport/plans/

### trusted-advisor
- https://aws.amazon.com/pt/premiumsupport/technology/trusted-advisor/
- Analiza falhas
- Desempenho
- gastos

### Acesso
- Console
- Management Tools
- Trusted Advisor

## SEGURANÇA

### AWS provê diversos serviços para garantir a segurança 
- AWS IAM - Gestão de Usuários e Acesso
- AWS KMS - Gestão de Certificados 
- AWS Shield - Proteção contra DDoS 
- AWS WAF - Firewall para Aplicações Web 
- AWS Inspector - Análise de Vulnerabilidades 
- AWS Guard Duty - Monitoração de ameaças baseado em Machine Learning 
- AWS Cognito - Gestão de Acesso para Aplicativos Móveis integrado com Facebook, Google, AWS, Active Directory, outros.

- Security groups - Firewall para instâncias EC2 e RDS
- Network ACl - COntrole de acesso a rede baseado em regras
- Route53 - Proteção a nível de DNS

> Rastreamento e Auditoria
- CloudTrail - Coleta de logs de Acesso a Recursos de API's
- CloudWacth - Monitora e gera alarmes de regras pré-definidas


## IAM : Identity and access management
- Controla quem pode fazer o que
- Serviço que controla acesso aos recursos na AWS
- Permite criar e controlar usuários, autenticação ou limitar acesso de usuários a recursos


| Autenticação (Quem) 		          	  | 				Autorização (Permissões)  					   |
| :-------------------------------------: | :------------------------------------------------------------: |
| AWS Management Console: User, Pass	  | Arquivo Json **Permissões em detalhes** **Users, Groups e Roles|
| AWS CLI ou SDK API: Access e secret key | 								   							   |

##	IAM
	GROUPS
USERS		ROLES
	POLICIES
#### Users
- Pessoa ou serviço que interage com a aws
	- Nome único
	- Conjunto de credenciais
	- Associado a apenas uma conta da AWS
	- Permite acesso de forma humana ou programa (API ou CLI)
#### Groups
- Grupo de usuários
	 - Agrupa usuários por departamento, função, afinidade, etc
	 - Usuários compartilham as mesmas permissões (Policies)
	 - Facilitam o gerenciamento de usuários
	 
#### Roles
-  Função/Papel que interage com a AWS
	- Usa as policies
	- Não possui credenciais
	- Chave de acesso são criadas dinamicamente
 	- Usuários, aplicações e serviços podem assumir IAM Roles
- EC2 -> IAM ROLE -> S3
	  <-		  <-
- Exemplo:
	- Uma máquina EC2 pode ter acesso a arquivos do S3 sem precisar de um usuário específico, apenas usando uma role.
	
#### Policies
- Definem QUEM tem acesso AO QUE e O QUE podem fazer
	- São descritas no formato Json
	- Por padrão não dão acesso a nada
	- Podem ser assinaladas para Users, Groups e Roles
	- Define em detalhes as ações que podem ser executadas
		- Quem		Teste
		- Ações		GET objetos no S3
		- Recurso	Bucket = "*"
		- Quando	Até Dezembro 2021
		- Onde		A partir do IP 179.20.1.1

#### Exemplo
```
{
  "Version": "2008-10-17",
  "Id": "Exemplo-Id",
  "Statement": [
      {
	"Sid": "Exemplo-statement-ID",
	"Effect": "Allow",
	"Principal": {
	   "Service": "s3.amazonaws.com"
	},
	"Action": "SNS:Publish",
	"Resource":"arn:aws:sns<region>:<account id>:<topic name>",
	"Condition": {
	   "ArnLike": {
	       "aws:SourceArn": "arn:aws:s3:*:*:<bucket name>"
	   }
	}
      }
  ]
}
```
- Users
	- Roles
	- Permissions
	- Groups
#### Password Rotation
- Mudança de senha por determinado período

### MFA
- Multi factor autentication

####		   POLICIES

##### MANAGED POLICIES						INLINE POLICIES
- Criadas e mantidas pela AWS				- Criadas pelos clientes
- Atualização automática					- Permite maior definição e granularidade
- Gerenciamento de mudança centralizada		- pode ser apagada quando o "principal" for apagado
- Reutilizável

### Pratica
- Console
- Security identity compliance
- IAM 
	- Link de acesso ao console
		- customize
	- Create individual IAm users
		- Manage Users
			- Add user
				- Programmatic access
				- AWS Management Console access
				- senha
				- alterar senha no próximo acesso
				- next 
					- add a um grupo
					- create user
				- Adicionar usuário a um grupo
				- Adicionar uma tag
					- opcional
				- Review
				- Vê senha, enviar para e-mail, download csv
	- Create group 
		- nome do grupo
		- filter policies
			- regras prontas para que você adicione
		- AdministratorAccess 
		- Create group 
	- Politicas para senha 
		- como será a senha 
- MFA 
- Altenticação de multiplos fatores
	- Manage MFA
		- Te dar três opções
		- A virtual MFA device
			- app no celular
		- U2F Security Key
		- A hardware MFA device
			- Dispositivo fisico "Antigo"
		- next 
			- App para usar no celular, autenticação de 2 fatores
			- Exemplo App: Authy Ou Google Autentication
				- Add conta 
				- scanner o código
				- nome para a conta 
				- código no app para site AWS
				- active
		
## Armazenamento S3
- S3 : Simple Storange Service
### Armazenamento Objeto
- As operações devem ser feitas no objeto como um todos
	- Ex: delete, upload, etc
	- Não se pode remove metade de uma foto
### Armazenamento em bloco
- As operações podem ser feitas em apenas alguns blocos de objetos (por partes).

#### S3 
	- Arm. objeto
	- Acesso imediato
	- alta durabilidade
	- alta disponibilidade
	- alta escalabilidade
	- Flexibilidade
	- Segurança 
	- Baixo custo
	- Ideal para objetos estáticos, sites, outros

#### Gracies 
	- Arm. objeto
	- Archiving
	- Acesso NÃO imediato
	- alta durabilidade
	- alta disponibilidade
	- alta escalabilidade
	- Segurança 
	- Baixo custo (< S3 )
	- Objetos arquivados, Backups, logs
	
#### EBS
	- Arm. bloco
	- Usando em instância EC2
	- Snapshot
	- alta disponibilidade
	- alta escalabilidade
	- Segurança 
	
#### EFS
	- Arm. Arquivos
	- Compartilhando entre instância EC2
	- alta disponibilidade
	- alta escalabilidade
	- Segurança 
	- Baixo custo
	- Dados corporativos
	**Pode ser conectado ao data center local via Direct Connect**

#### Storage Gateway
	- Arm. híbrido
	- Segurança
	- Permite conectar arquivos, volumes e backups entre AWS e Storange Local
	- Local Storage
	
#### Snowball 
	- Tranferência de dados para aws
	- Dispositivo físico
	- Suporte petabytes
	- Criptografia
	- Rastreamento
	- Amazon envia e coleta
#### Snowball Edge
	- Dispositivo para processamento de serviços como EC2 e Lambda
	- Suporta 100 TB
	- Permite utilização em locais sem acesso a Cloud e posterior sincronização
	- Segurança
	- Gerenciamento
	- Usam em: Navios, fabricas, Desertos
	- Dispositivo físico
	
#### Snowmobile
	- Tranferência para dados aws
	- Caminhão + Container
	- Suporta 100 PB
	- Criptografia
	- Rastreamento
	
### S3 - Armazenamento
- Componentes
	- Object Base 
		- Ao subir o arquivo
			1. Ler o arquivo antes de subir
			2. Escrever
			3. Enviar para outras Regions, EDGE Location
		- Key 
			- Baseado no nome do arquivo
		- Value
			- Dados do arquivo
		- Version
			- Versão do arquivo
		- Metadada
			- armazenamento dos dados 
				- informações no cabeçalho do arquivo
				- TAG, Local 
		- ACL
			- file
- Simples Storange Service é um serviço de armazenamento de objetos que permite armazenar e recuperar qualquer quantidade de informaç~eos via internet, pagando apenas pelo o que user.
	- Provê interface Web (console)
	- Permite acesso via CLI e SDK 
	- Possui 99.999999999% de Durabilidade
	- Possui 99.99% de Disponibilidade
	- Permite arquivos de até 5TB de tamanho
	
### Conceitos Importantes
- Objetos no S3 são armazendos em **Buckets**
- Nomes dos objetos são chamados de **Object key**
- Versões dos Objetos são chamados de **Version ID**
- Endereço dos objetos são chamados de **Link Address**

- Link Address
	- https://s3.amazonaws.com/aws-curso-videos/aws4final_720.mp4
- Bucket
	- aws-curso-videos
- Object Key
	- aws4final_720.mp4
### Definições para objetos e Buckets

### Classes de Armazenamento
- Frequência de acesso
- Tempo de recuperação
- Preço 
#### Classe de armazenamento (Storange Class)
##### S3 TIER 
- S3 Standard 
	- Padrão
	- Acesso frequente e imediato
	- Usado para aplicações em cloud, websites, game, websites, big data, videos, etc.
- S3 Standard for infrequent access
	- Acesso não frequente
	- Acessso imediato
	- Usado para  backups, disaster, recovery, dados de vida longa 
- One zone infrequent access
	- Acesso não frequente
	- Acesso imediato 
	- Mantido em apenas uma zona de disponibilidade
	- Usado para dados frequente mas não critico.
- Glacier
	- Para dados arquivados
	- Acesso não frequente
	- Acesso não imediato (pode demandar horas)
	- Usado para backups, archiving, logs 
- Reduced redundacy 
	- Para dados arquivados
	- Acesso frequente
	- Acesso imediato
	- Baixa redundância
	- Usado para dados que podem ser novamente repoduzidos, como livros eletrônicos

##### Politica de acesso (policy)
- Versionamento
- Criptografia
- Cliclo de vida (lifecycle)
	- S3 permite que ações de gerenciamento de ciclo de vida de objetos possa ser criada à partir de regras
	- Transition Actions 
		- Objetos podem ser movidos entre Classes de Armazenamento, após certo período, melhorando assim os custos de armazenamento.
		- S3 permite que ações de gerenciamento de ciclo de vida de objetos possa ser criada à partir de regras
		
|                                       Serviço										   |  Dias	 |            Serviço    					   |	Dias	|Serviço  |
| :----------------------------------------------------------------------------------: |:------: |:-------------------------------------------:| :--------: | :-----: |
|S3 Standard																		   | 30 Dias | S3 IA									   | 60 Dias	|  Glacier|
|Arquivos contábeis não utilizados por30 dias, podem ser movidos para infrequent Access|         |Após 60 dias podem ser movidos para o Glacier| 			|Arquivado|

- CROSS-REGION Replication
	- Funcionalidade que permite a replicação de objetos de um bucket em uma região para um bucket em outra região
	- Versionamento precisa está habilitado.
	- Útil para backup, reproduzir latência ou até para atender a requisitos legais.
		- Região São PAulo -> Região Paris
- Transfer Acceleration
	- Utilizado quando necessario de tranferência de grandes quantidades de dados em uma distância muito longa
	- Edge Location com **CloudFront** é utilizado para otimizar o caminho


### Criando Bucket
- Console
- Storange
- S3
	- Create bucket
		- nome único
		- Região
			- [Verificar preço](https://aws.amazon.com/pt/s3/pricing)
		- Copia de algum outro bucket
		- next
		- versionamento
		- gerar logs de chamados
		- Tag para pesquisa
		- next 
		- permissões
		- resumo
	- Upload para bucket
		- Upload
			- add files
			- dar acesso
				- público
				- privado
			- next e upload
		- Create folder
	- Entra no bucket
	- link do objeto dentro do bucket 
	- Dar permissão para acesso público
		- Aba Permissions
			- Public access	
				- Everyone
					- Marque o **Read object**
	- Criando Pasta
		- Create folder
			- nome
			- encriptação
			- save
	- Criando Arquivo dentro da pasta
		- clique na pasta que você criou
			- Upload
			- add files
				1. Manage users
					- read, write
					- quem pode acessar
				2. Selecionar a TIER
				3. OverView
		- Visualização do arquivo
			- clica no arquivo
			- para tornar publico
				- volta no S3 bucket
				- Clique em: 
					- Edit public access setting
					- save
					- Escreva confir
				- volte onde está o objeto que quer deixar publico
				- em Actions
				- Make Public
- As permissões podem ser aplicadas em:
	- buckets
	- folders
	- files
				
### Configurando web site estático
- Console
- S3 
	- Cria um novo backet 
		- Na página dos backets 
		- clique no bucket
		- propriedades
		- habilitar **Static website hosting**
		- nome do arquivo principal
		- nome de página de erro
		- endereço do site fica em cima
		- save 
		- faz upload dos arquivos 
		- tem criar politica para acesso ao site
		- no seu bucket acesse
			- Permissions
			- Bucket policy
			- save
```
{
  "Version":"2012-10-17",
  "Statement":[{
        "Sid":"PublicReadGetObject",
        "Effect":"Allow",
          "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::nome-do-bucket/*"
      ]
    }
  ]
}
```
				
## EC2
- computador (Máquina Virtual)
- Windows / Linux
- Baixo custo
- Configurações diversos
- Tamanho variados
- Seguro
- Escalável
- Big data, ERp, CRM, Aplicações em escala, e-Commerce

### ECS
- Gestão de containers
- Suporte a Docker
- Escalável
- Baixa custo
- Seguro
- Fácil integração com outros serviços AWS 

### LAMBDA
- Serveless
- Basta carregar código e radar
- Escalável
- Cobrado por execução
- Suporte a diversas tecnologias
- Fácil integração com demais serviços AWS

### LIGHTSAIL
- Servidor virtual pré configurado
- Permite instalações pre configuradas
- Wordpress, Drupal, Joomla
- Baixo custo
- Fácil implementação 
- Integração com os demais serviços AWS 
- e-Commerce, Web sites, Wordpress, etc

### ELASTIC BEANSTALK
- Deploy de aplicações na Web
- PaaS - Plataforma como serviço
- integração com Git e IDEs (Dev)
- Provisionamento automático
- Escalável
- Seguro
- Automatizado


### Elastic Compute Cloud
- AWS EC2: O Elastic Compute Cloud (Amazon EC2) é um web service que disponibiliza capacidade computacional segura e redimencionável na nuvem. Ele foi criado para facilitar para os desenvolvedores a computação em nuvem na escala da web.
- Iniciais de máquina
	- C : Computer Optimized
		- Mais CPU de que memória
	- G : Grafics
		- Placa de vídeo melhor
	- D : Dense Storange
		- Para servidores de arquivos e ware houses
	- R : Memory Optimized
		- Quantidade de mémoria maior
	- M : General
		- Servidores que não requer muito procesamento
	- I : High Speed Storange
		- Para banco de dados
	- F : Programming
		- Programação
	- T : Web Service
	- P : GPU/ Mining
		- Mineração de bitcoin
	- X : Memória 
		- Máquina com servidor Apache
		
- Instância EC2 (Máquina Linux ou Windows)
	- Quantidade e tipo CPU
	- quantidade Memória RAM
		- Tipos de máquinas
			- T2
				- Uso geral
			- C5
				- Otimizada para computação
				- Desempenh melhor 
			- X1, R4, R5
				- Otimizada p/ memória
				- melhor para BD
			- P3, G3
				- Computação Acelerada
				- Processamento de Maqchine learning, Games ...
			- H1, I3
				- Otimizada Armazenamento
	- Tam e tipo de disco EBS
		- SSD (gp2)
			- Uso geral
		- SSD Prov IOPS (io1)
			- Permite definir IOPS
		- HDD (st1)
			- Disco magnetico
	- Modalidade
		- On demand
			- Sob demanda
			- Pay as you go
			- Preços por hora
			- T2.micro 
				- Free Tier 
		- Reserved Instances
			- Reserva por 1 ou 3 anos
			- Desconto de até 75%
			- Pagamento à vista ou parte à vista parte mensal
		- Spot Instances
			- Leilão
			- Cliente define um preço a pagar pela capacidade ociosa da AWS
			- Se o preço é aceito instância é provisionada
		- Dedicated Host
			- Servidor dedicado
			- máquina fisica
			- Preço por hora 
			- Desconto podem chegar a 70% 
			
### Subir Instância EC2 			
- Console
- Compute
- EC2
	- Selecione a região
	- Key pairs
		- create Key Pair
			- Nome 
			- Download do arquivo
	- EC2 dashboard
	- Running instance
	- Launch instance
	- Escolhe S.O da sua Máquina
	- Tipo da instância
		- Free Tier
	- Next
	- Número de instâncias
	- Auto-assign Public IP = Enable
	- Next
	- Em ADD Storage (Vê capítulo anterior)
	- Next
	- Tag	
		- Primeira máquina
	- next
	- Configure Security group
		- Firewal para suas instâncias
		- nome e descrição
		- Review
	- Lauch
	- Criar um key pair o selecionar um existente
	- Launch
	- View Instance
- Acessando a máquina
	- Selecione a instância 
	- Actions 
	- Connect
	- Exemplo de como conectar
- Configurando via SSH
	- Standalone SSH
	- Open SSH em sua máquina
	- permissão a key pair que você criou
	- pegar o nome da instância 
##### Linux
- pelo terminal de seu pc faça
	- entre na pasta onde está o arquivo
	- Dê permissão 
		- chmod 400 nome da key pair
	- ssh -i "nome da instância"
	- yes
	- pronto conectado
##### Windows

- puttygen
	- para gerar chave privada
	- abre o app
	- load 
	- escolhe o key pair gerado no capitulo anterior
	- Save Private key com:
		- RSA
		- 2048
	- salva com senha o sem senha
	- fecha o puttygen
- putty
	- para acesso a máquina7
	- pega o Public ip ou o DNS
	- coloca no hosting
	- port : 22
	- SSH
		- Auth
			- No Browser
			- escolhe arquivo gerado pelo puttygen
			- volta para o session
	- open
	- login	
		- user: ec2-user
	- pronto

### Roles em EC2

#### Acessando S3 via EC2
- No console da máquina, já logado na instância pelo terminal
- Digite: aws
- aws help
- aws s3 ls
	- a princípio você não terá acesso
- Entre no console do EC2
	- Runnig Instances
		- Actions
		- Instance Setting
		- Attach replace IAM Role
			- Create new IAM role 
			- create role - para ec2 acessar s3
			- AWS service
			- EC2
			- Next
			- POLICES: permissão para recusos dentro da AWS
			- Em pesquisa, digite s3
			- AmazonS3FullAccess
			- Next
			- role name 
			- descrição
			- Create role
- vá para a instância do EC2
- Runnig Instances
- Instance Setting
- Attach replace IAM Role
- Selecione a role criada 
- apply
- close
- já é possível acessa o S3 via terminal
	- aws s3 ls
	- aws s3 ls s3://nome-bucket
	
### EBS para EC2
- Elastic Block Storange
#### Volumes
- IOPS
	- Input/Output Per Second
##### GP2
- SSD
##### Provisioned
- SSD (IO1)
	- Alta performance (MySql, SQL)
	- Mais de 10.000 IOP
##### SP1
- HDD	
	- Data
	- Logs
	- Não BOOT (Não O.S)
##### SCJ
- Cold HDD
	- Data
	- Logs
	- Não BOOT (Não O.S)
##### Magnetic (Standard)
- HDD
- IA
- Aceita Boot


- Console do EC2
- Volumes
- Boa prática
	- fazer snapshot do disco | Copia
- Para Fazer o Snapshot
- No menu Snapshot
	- Create Snapshot
	- Qual volume
	- Descrição
	- Create snapshot
	- close
	- estará sendo criado uma cópia do disco
- outra forma
	- Clique no menu na opção
	- Lifecycle Manager
	- Create snapshot lifecycle police
	- Descrição
	- parametros de configuração
	- Automatiza a criação do snapshot
	
## LIGHTSAIL
- [SITE](https://aws.amazon.com/pt/free/compute/lightsail)
- Opções de vários aplicativos
	- Drupal
	- Magento
	- XAMPP
### Crinado aplicação
- Console
- Compute
- Lightsail
	- Criar instância
		- Definir região
		- S.O
		- Aplicação
			- Quando subi o S.O ele já instala a aplicação
		- Nome instância
	- Conecta-se a instância
		- Clicando em conectar ele abre um aba com o CLI SSH
	- Exemplo de Instalação do Wordpress
		- Usuário
			- user
		- pegar senha	
			- Conectar ao SSH
			- digitar
				- cat bitname_application_password

### Subindo Instância Windows 2019 Server
- Computer
- EC2
- Launch Instances
	- Step 1: Amazon Machine IMage (AMI)
		- Escolhe o S.O: Select
	- Step 2
		- Escolhe a instancia
		- cpus
		- memória
	- Step 3: Detalhes da instancia
		- Número de instancia que vai subir
		- Network
		- Endereço publico
		- Shutdown behavior: pode destruir a máquina ao desligar
	- Step 4: Add Storage
		- Volumes
		- tamanho GB
	- Step 5: Tags
		- Nome máquina
		- chave valor
		- quem criou
	- Step 6: Security group
		- Firewall
		- filtra o trafego
		- nome security group
		- pode ser acessado por quem
		- anywhere : qualquer lugar do mundo
	- Step 7: review
		- Launch
- Criar chave pública
	- create new key par 
	- nome
	- download
	- launch
- view instances 
- nome para a máquina
- selecione a instância
- connect
- Download remote desktop file
- get Password
	- vai pedir a key par criada anteriormente
	- selecione onde você salvou
	- decrypt password
	- vai te dar a senha de adnistrador
- clique 2x no arquivo que você baixou: remote desktop file
- coloque a senha
- Habilitar acesso ao IE
	- Menu
	- Server manage 
	- local server 
	- IE Infromation Security Configuration: Coloca OFF
- Para a máquina
	- Actions 
		- Interface State 
			- Stop
			- yes, stop
- Apagar instancia
	- Actions 
		- Instance Setting 
			- Change Terminate Protection
			- yes, disable
		- Interface State 
			- Terminate
			- yes terminate
	
## Banco de Dados

### Principais

#### DynamoDB
- Serverless
- NoSQL
- Totalmente gerenciado
- Escalável
- Seguro
- Recomendado para:
	- Aplicações Web
	- Mobile
	- IoT
	- Jogos
	
#### RDS
- 100% Gerenciado
- Permite escolhe tipo da instância
- Escalável
- Backup
- Aplicações patches
- Alta performance
- Seguro
- Baixo custo
- Instâncias Disponiveis
	- PostgreSQL
	- Amazon Aurora
	- Oracle
	- MySql
	- MariaDB
	- SQLServer

#### RedShift
- 100% Gerenciado
- Dataware House
- Escalável
- Big Data
- Data Lake

### Criando um serviço RDS
- Console
- Database
- RDS
	- Selecione a região
	- Create database
		- Qual banco
			- Exemplo com MySql
			- Next
			- Use case
			- Versão do Banco
			- Tamanho Instância
			- Indetificação da instancia
			- usuário
			- senha
			- Next
		- Configurações avançadas de rede
			- Se não soube configurar não mexa
			- Deixe apenas o acesso publico
		- Database Options
			- Nome do banco
			- portal
			- grupo
		- Backup
		- Create database
- Vê instâncias prontas
	- No menu dashboard
	- Instânces
	- Clique no nome da instancia
- Conectando o banco com instância externa
	- Exemplo com **TeamSQL**
	- Create connection
	- cria a conexão para o banco
	- Type: Mysql
	- Noma da conexão
	- Host: pegar o endpoint 
	- Porta: 3306
	- User
	- pass
	- DBname
	- Test Connection

















	
			

		




























- 					

					
		
	









	































				
				

























































































