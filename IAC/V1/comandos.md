
- Inicia o projeto
    - terraform init
- Mostra um planejamento de como foi feito
    - terraform plan
- Aplica as alterações e cria a instancia na AWS
    - terraform apply

yes

> O bloco provider {} descreve características de um provedor específico, como a região da AWS.
> O bloco resource {} descreve o tipo de recurso a ser criado, como uma instância, por exemplo.

## Acessando a máquina
- Criar chave SSH
- Rede e segurança > par de chaves
    - .pem padrão para linux
- Associa as chaves a main.tf, em resouces
```
key_name = "nome_da_chave"
```

### Grupos de segurança na AWS
- Editar regra de entrada e saída
    - todo tráfego
    - anywhere ipv6
