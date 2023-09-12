## Instalação do jenkins

sudo apt update
sudo apt install openjdk-17-jre

## Verifica versões do jenkins
- sudo update-java-alternatives --list
- sudo update-alternatives --config java
- Seleciona o numero e aperte Enter
- java -version

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins.service
sudo systemctl status jenkins


## Remover Jenkins
sudo apt-get remove --purge jenkins
rm -rf /var/lib/jenkins
sudo getent passwd | grep jenkins
jenkins:x:978:974:Jenkins Automation Server:/var/lib/jenkins:/bin/false
sudo getent group | grep jenkins
jenkins:x:974:
sudo userdel jenkins
sudo getent passwd | grep jenkins
sudo getent group | grep jenkins
ps -ef | grep jenkins
ubuntu 14433 8171 32 14:54 pts/0 00:00:43 java -jar jenkins.war
ubuntu 14824 14618 0 14:57 pts/1 00:00:00 grep --color=auto jenkins
sudo kill -9 14433
rm -rf /root/.jenkins/
cd $CATALINA_HOME/bin
bash catalina.sh stop

[Classpath java](https://www.vivaolinux.com.br/dica/Configurando-JDK-no-PATH-no-Linux-qualquer-distro)
[Ref](https://stackoverflow.com/questions/70541720/jenkins-has-no-installation-candidate-error-while-trying-to-install-jenkins-on)
[Ref](https://www.baeldung.com/linux/remove-jenkins)
