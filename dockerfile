##
FROM alpine:latest

RUN apk update;apk add bash python python3 curl groff vim
#SHELL ["/bin/bash", "-c"]

RUN curl --silent --location https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
RUN python /tmp/get-pip.py --user
RUN echo "PATH=~/.local/bin:$PATH" >> ~/.bashrc
RUN echo "PATH=~/.local/bin:$PATH" >> ~/.profile

RUN pip3 install --upgrade pip
RUN pip3 install awscli --upgrade --user

RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
RUN mv /tmp/eksctl /usr/local/bin

RUN curl --silent --location https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl -o /tmp/kubectl
RUN chmod +x /tmp/kubectl
RUN mv /tmp/kubectl /usr/local/bin

RUN curl --silent --location https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator -o /tmp/aws-iam-authenticator
RUN chmod +x /tmp/aws-iam-authenticator 
RUN mv /tmp/aws-iam-authenticator  /usr/local/bin

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION
ARG CLUSTER

VOLUME /root/.aws
VOLUME /root/.kube
VOLUME /project
COPY init.bsh /