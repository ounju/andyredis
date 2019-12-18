FROM ubuntu
WORKDIR /andy
RUN apt update; apt install vim telnet wget -y; apt upgrade -y
RUN apt update; apt install apt-transport-https ca-certificates curl software-properties-common -y; apt update; apt upgrade -y
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt update; apt upgrade -y
RUN apt-cache policy docker-ce
RUN apt install docker-ce -y
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-jessie main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-lucid main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-precise main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-squeeze main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-stretch main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-trusty main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-wheezy main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
#RUN add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-yakkety main"
RUN apt update; apt upgrade -y; apt install kubelet kubeadm kubectl kubernetes-cni -y
RUN wget https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip
RUN apt install zip -y
RUN unzip terraform_0.12.18_linux_amd64.zip
RUN mv terraform /usr/bin
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh
