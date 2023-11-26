## Ansible e Python

> Destroy a máquina na aws
- terraform destroy

> Executa como super usuário
- become: yes

### Rodar playbook
- ansible-playbook playbook.yml -u ubuntu --private-key iac-alura.pem -i hosts.yml

- No server
    - vá em tcc
    - ls
    - . venv/bin/activate
    - pip freeze
    - Mostra as dependências do python instaladas

### Criando projeto em python
- django-admin startproject setup .
- ls
- python manage.py runserver 0.0.0.0:8080

### Corrijindo erro do Django
- Nós subimos uma máquina com Django, só que na hora que fizemos a requisição para conseguir ver aquela página do Django que foi criada, se tudo foi instalado corretamente, nós recebemos uma mensagem, ele fala que DisallowedHost. Parece uma mensagem meio maluca, mas quem trabalha com Django sabe que essa mensagem se trata das requisições que a nossa aplicação tem permissão de receber ou não.
- cd setup
- nano settings.py
- Em ALLOWED_HOSTS
```
ALLOWED_HOSTS = ['*']
```
- python manage.py runserver 0.0.0.0:8080