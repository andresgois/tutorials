# Gitlab CI e Docker: Pipeline de entrega contínua

## Comandos no GitLab
### Protejer Branch
- Settings > Repository > Protected Branches
    - Unprotect

### IMPORTANTE
- Identação
- O arquivo responsável por configurar todas as etapas da integração contínua é o .gitlab-ci.yml, que deve se criado na raiz do seu projeto, tendo como base uma indentação par. Caso essa regra seja quebrada, a integração não funcionará.
- Aponta projeto para o GitLab
    - git remote add gitlab git@gitlab.com:andresgois1/bytebank.git
    - git add --all
    - git commit -m "apontando versionamento"
    - git push gitlab master -f