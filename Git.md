
# GIT

## Git 
- Sistema de controle de versão

```mermaid
  flowchart TD
      id1([Version 1])-->id2([ A ])
      id2([A])-->id3([ B ])
      id3([B])-->id4([ C ])

      style id1 fill:#FFA09A,stroke:#000,stroke-width:2px,color:#000
      style id2 fill:#BEE9C9,stroke:#000,stroke-width:2px,color:#000
      style id3 fill:#BEE9C9,stroke:#000,stroke-width:2px,color:#000
      style id4 fill:#BEE9C9,stroke:#000,stroke-width:2px,color:#000,stroke-dasharray: 5 5

```

#### Vantagens
- Velocidade
- Design simples
- Suporte robusto a desevolvimento não linear (milhares de branches paralelos)
- Totalmente distribuído
- Capaz de lidar eficientemente com grandes projetos como o kernel do Linux.

## Github 
- Serviço de web compartilhado para projetos que utilizam o **Git** pata versionamento
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
- Visualizar configurações específicas
    - git config core.editor
    - git config user.email
### Iniciando GIT
- git init


### Ciclo de vida do Status
- untracked: **Ainda não foi visto pelo git**
- unmodified: **Não teve modificação**
- modified: **Foi editado, mas não foi salvo**
- staged: **Pronto pra commitar**

```mermaid
sequenceDiagram
    par untracked to unmodified
        untracked->>unmodified: Add the file
    and unmodified to modified
        unmodified->>modified: edit the file
    and modified to staged
        modified->>staged: stage the file
    end
    staged->>unmodified: stage the file
    unmodified->>untracked: remove the file

```

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
    - **Sem precisar dar git add**
    - git commit -am "mensagem
    - Adiciona e comitar tudo
        - git commit -ma "mensagem
- Adiciona a um reporitório remoto
    - git push
- Logs do git
    - git log
    - **Mostra sobre branches, Tags**
    - git log --decorate
    - **Filtra por author**
    - git log --author="andre"
    - **Log em ordem**
    - git shortlog
    - **Quantidade de logs e author**
    - git shortlog -sn

- Logs Reduzidos
    - git log --oneline
- Vê o desenho do grafo de commits
    - git log --graph
    - git log --graph --oneline
- Ramo que o projeto esta
    - git branch
- Verifica se já esté em um repositório remoto
    - git remote
- Mostra a descrição de arquivo específico
    - git show hash_do_commit
- **Vê mudanças antes de enviar**
     - git diff
     - git diff --name-only

### Desfazendo coisas com o reset
- **Alterou o arquivo, mas se arrependeu**
- git checkout nome_arquivo
- **Resetar mudanças depois do ADD**
- git reset HEAD
- **Resetar mudanças depois do COMMIT**
    - Três tipos
        - **--soft**
        - Não desfaz apenas o commit, não destroi as mudanças
        - **--mixed**
        - Não desfaz apenas o commit, volta para antes do stage
        - **--hard**
        - ignora a existência do commit e tudo que foi feito
- git reset HEAD **Escolher commit anterior ao que você quer reverter
- git reset --soft b452888664564c65454c64e6565
- git reset --hard **ele altera o historico de commits, tome cuidado**
#### Rastrear as mudanças nas versões do projeto e recuperar uma versão
- git checkout hash_do_commit
- git branch
- git checkout master

#### Desfazer alterações
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
## Criando chave SSH
[Gerar uma nova chave SSH](https://docs.github.com/pt/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

[Adicionar uma nova chave SSH à sua conta do GitHub](https://docs.github.com/pt/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

### Adicionar chaves no github
- Página inicial do github
- Settings
- No menu clique em: **SSH and GPG Keys**
- Clique em: **New SSH key**
- coloque um título e a chave

## Clonando repositório
- Útil quando:
- Quando quiser trabalhar em repositorioas open source
- Clona seu repositório em outra máquina
- git clone https://github.com/andresgois/vite-react-mui.git novo_nome_para_repositorio

## Fork
- Faz uma cópia de uma projeto terceiro e coloca no seu github
- pode abrir pull request enviando para o administrador do repositório original

## Criando ramificações do projeto
- Branch
    - É um ponteiro móvel que leva a um commit.
    - A branch aponta para commits
```mermaid
    flowchart LR
    subgraph BRANCH
    master-->C2
    C2-->C1
    C1-->C0
    teste-->C3
    C3-->C2
    end
```

### Vantagens
- Poder modificar sem alterar o local principal(master)
- Facilmente "desligável"
- Evita comflitos
- Múltiplas pessoas trabalhando

### Criar branch
- Criando nova ramificação
    - git checkout -b novo_ramo
- Crie alguns arquivos no novo_ramo
- add e commit
- volte para a branch master
- Mostra o gráfico de todas as branchs
    - git log --oneline --graph --all

### Movendo entre branches e deletando
- **Mostra a branch atual**
> git branch
- **Mudar de branch**
> git checkout nome_branch
- **Deletar branch**
> git branch -D nome_branch
- ****
>

### Entendendo o Merge
- Ele cria C6 para juntar todas as alterações de C3 e C5 com C4.
- Forma diamante

```mermaid
    flowchart LR
    subgraph Fazendo o Merge    
    master-->C6
    C6-->C5
    C6-->C4
    C4-->C2
    C5-->C3
    C3-->C2
    C2-->C1
    C1-->C0
    ISS53-->C5
    end
```
| PRO | CONTRA|
|:--------------------: |:----------------:|
|Operação não destrutiva|   Commit extra   |
|                       | Histórico poluído|

### Rebase
- Move o commit C3 e move para a frente, no caso o C4
- Move sempre para o inicio da fila
- ao final tanto a branch master como a experiment vão apontar para o mesmo commit, no caso C3'.

```mermaid
    flowchart LR
    subgraph Fazendo o Merge    
    master-->C4
    C4-->C2
    C2-->C1
    C1-->C0
    experiment-->C3'
    C3'-->C4
    C3-->C2
    end
    style C3 fill:#bbf,stroke:#000,stroke-width:2px,color:#000
```
|                   PRO | CONTRA             |
|:--------------------: |:------------------:|
|Evita commits extras|Perde ordem cronológico|
| Histórico linear   |                       |

- **Evita perca de histórico**
> git pull --rebase

#### Merge vs Rebase
|                   Merge                 |                 Rebase              |
|:--------------------------------------: |:-----------------------------------:|
|Cria novo commit pra juntar as diferenças| Joga mudanças para o inicio da fila |
#### VS Code
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



## IMPORTANTÍSSIMO
- **Mostra a diferenças entre arquivo antigo e alterado antes de *Adicionar*.**
> git diff
- **Remover arquivo da stage area**
> git reset HASH
- **Remove o commit para o commit passado com HASH, no mínimo tem que pegar o anterior**
    - **volta commit pra stage area**
    > git reset --soft HASH
    - **volta commit para ADD**
    > git reset --mixed HASH
    - **Remove commit e modificações**
    > git reset --hard HASH

##

## Ao Criar repositório no GitHub
### …or create a new repository on the command line

```
echo "# vite-react-mui" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/andresgois/vite-react-mui.git
git push -u origin main
```

### …or push an existing repository from the command line
```
git remote add origin https://github.com/andresgois/vite-react-mui.git
git branch -M main
git push -u origin main
```

## Referências
[Willian Justen Cursos- Curso de Git básico](https://www.youtube.com/watch?v=g2uviTb8ZpE&list=PLlAbYrWSYTiPA2iEiQ2PF_A9j__C4hi0A&index=14&ab_channel=WillianJustenCursos)

[Curso GIT e GITHUB](https://www.youtube.com/watch?v=Xsulc8agj_A&list=PLbEOwbQR9lqzK14I7OOeREEIE4k6rjgIj&index=10&ab_channel=ProfessorJos%C3%A9deAssis)