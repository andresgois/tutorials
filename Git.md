
# GIT

### Git 
- Sistema de controle de versão
### Github 
- Rede social de projetos

### Outras Alternativas 
- Gitlab
- Bitbucket
- subversion

### Vantagens
- Backups
- Controle de versões
- Trabalhar em equipe
- Portfólio
- Contribuir com projetos Open source

### Instalar e configurar no Windows
- [Site Official](https://git-scm.com/)
- Comandos para configurações do git
    - git config --list
    - git config --global user.name "Teste"
    - git config --global user.email "teste@gmail.com"
    - git config --global core.editor "caminho do editor"

### Processo do GIT
| Processo                      |
| :---------------------------: |
| WORKING DIRECTORY             |
|   *git add .*                 |
| STAGING AREA                  |
| *git commit -m "mensagem"*    |
| REPOSITORY                    |

### Comandos Básicos
- Inicia o repositorio
    - git init
- Status do git
    - git status
- Adiciona os arquivos
    - git add .
    - git add *
    - git add nome-arquivo.txt
- Envia os arquivos para a stagin area
    - git commit -m "mensagem
    - Adiciona e comitar tudo
        - git commit -ma "mensagem
- Adiciona a um reporitório remoto
    - git push
- Logs do git
    - git log
- Logs Reduzidos
    - git log --oneline
- Vê o desenho do grafo de commits
    - git log --graph
    - git log --graph --oneline
- Ramo que o projeto esta
    - git branch
- Verifica se já esté em um repositório remoto
    - gti remote

#### Rastrear as mudanças nas versões do projeto e recuperar uma versão
- git checkout hash_do_commit
- git branch
- git checkout master

#### Desfazer alterações
- Arquivo não adicionado ao container
- revisão antes do commit
- git diff
![Git diff](./imagens/git/git_diff.png)
    - Em vermelhor arquivos retidos
    - Em verde arquivos adicionados
- git status
- Descarta as mudanças e volta para modo anterior
    - git restore index.html
- Arquivo já adicionado ao container
- git add .
- remove o contaúdo do container
    - git restore --staged . | pode colocar o nome do arquivo no lugar do ponto
    - para remover arquivos do add
        - git restore . | nome do arquivo
![Git restore](./imagens/git/git_restore.png)

#### Excluir um commit
- git reset --hard 3ee9278

#### Criando ramificações do projeto
- Criando nova ramificação
    - git checkout -b novo_ramo
- Crie alguns arquivos no novo_ramo
- add e commit
- volte para a branch master
- Mostra o gráfico de todas as branchs
    - git log --oneline --graph --all
- faça alterações no ramo master, de preferencia faça nos mesmo arquivos da novo_ramo
- add e commit

- **git merge novo_ramo**
- Quando a conflitos no GIT
- VS Code alerta
    - Accept current change
        - Mantém a linha do ramo master
    - Accept incoming change
        - Mantém arquivo do novo_ramo
    - Accept both changes
        - Mantém arquivo de ambos
    - Compare changes
        - Comparação refinada

Aula 09
https://www.youtube.com/watch?v=Xsulc8agj_A&list=PLbEOwbQR9lqzK14I7OOeREEIE4k6rjgIj&index=9&ab_channel=ProfessorJos%C3%A9deAssis