# Linux

## Distribuições linux
- SUSE
- Ubuntu
- RedHat
- Elementary OS
- Debian

## Comandos

### Versão
- uname ```Linux```
- lsb_release -a 

```
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.3 LTS
Release:	22.04
Codename:	jammy
```

- cat /etc/os-release 
```
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```

- Descompactar arquivo
```
unzip imagens-livros.zip
```

## Instalações
- conversor de imagens
```
sudo apt install graphicsmagick-imagemagick-compat
```
- Uso
`convert algoritmos.jpg algoritmos.png`

## ShellScript

- Indicamos qual vai ser o interpretador do script
```#!/bin/bash```

- Passando paramentro
    - bash meu_script.sh `asp_net` `big_data`
- Define contante com caminho da imagem
```
#!/bin/bash

PATH=~/Downloads/imagens-livros

convert $PATH/$1.jpg $PATH/$1.png
convert $PATH/$2.jpg $PATH/$2.png
```
- primeiro parametro: `$1` e assim por diante


- Ao utilizar nomes de arquivos ou diretórios que incluem o carácter espaço devemos colocar aspas duplas não apenas no PATH, mas também na variável ao chamá-la. Segue o exemplo:

```
#!/bin/bash

CAMINHO="~/Documentos/Aula linux/imagens-livro"
cd "$CAMINHO"
```
