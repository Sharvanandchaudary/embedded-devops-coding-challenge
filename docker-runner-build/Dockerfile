FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    libicu-dev \
    netcat-traditional \
    netcat-openbsd \
    jq \
    unzip \
    wget \
    nodejs \
    sudo \
    python3 \
    python3-pip \
    git \
    openssh-client \
    gcc \
    python3-dev \
    gh \
    pipx

WORKDIR /gh-runner

ARG GITHUB_RUNNER_VERSION="2.310.2"
ARG TG_VERSION="v0.52.3"
ARG TRIVY_VERSION="0.47.0"
ARG TF_VERSION="1.5.7"
ARG TF_PROFILE_VERSION="v0.4.0"

RUN mkdir -p bin


#COPY actions-runner-linux-x64-2.296.2.tar.gz .
RUN curl -o actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz -Ls https://github.com/actions/runner/releases/download/v${GITHUB_RUNNER_VERSION}/actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz
RUN tar xzf actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz

#COPY kubectl .
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

RUN chmod +x ./kubectl
RUN mv ./kubectl /gh-runner/bin

#COPY helm-v3.8.2-linux-amd64.tar.gz .

RUN curl -o helm-v3.9.3-linux-amd64.tar.gz https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz

RUN tar xvf helm-*-linux-amd64.tar.gz

RUN mv linux-amd64/helm /gh-runner/bin

#Install trufflehog
RUN mkdir trufflehog && cd trufflehog
RUN curl -Lo trufflehog_3.62.1_linux_amd64.tar.gz https://github.com/trufflesecurity/trufflehog/releases/download/v3.62.1/trufflehog_3.62.1_linux_amd64.tar.gz
RUN tar xvf ./trufflehog_3.62.1_linux_amd64.tar.gz
RUN mv trufflehog /gh-runner/bin

#Install tfsec
RUN curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

#Install trivy
RUN mkdir trivy && cd trivy
RUN curl -Lo trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz https://github.com/aquasecurity/trivy/releases/download/v0.47.0/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz
RUN tar xvf ./trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz
RUN mv trivy /gh-runner/bin

#Install  Terraform

RUN curl -Lo terraform_${TF_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
RUN unzip -o terraform_${TF_VERSION}_linux_amd64.zip
RUN  mv terraform /gh-runner/bin


#Instal terragrunt
RUN curl -Lo terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_amd64

#Install tf-profile
RUN curl -Lo tf-profile.zip https://github.com/datarootsio/tf-profile/releases/download/${TF_PROFILE_VERSION}/tf-profile-${TF_PROFILE_VERSION}-linux-amd64.zip

RUN unzip tf-profile.zip
RUN rm tf-profile.zip
RUN chmod +x tf-profile*
RUN mv tf-profile* /gh-runner/bin/tf-profile

RUN chmod +x ./terragrunt && mv ./terragrunt /gh-runner/bin

RUN pipx install awscliv2
RUN pipx install --include-deps requests && pipx ensurepath
RUN pip3 install --break-system-packages Jinja2
RUN pip3 install --break-system-packages python-swiftclient
RUN pip install --break-system-packages python-keystoneclient

RUN cp /root/.local/bin/* /gh-runner/bin

COPY entrypoint.sh .

RUN chmod +x ./entrypoint.sh


COPY exitpoint.sh .

RUN chmod +x ./exitpoint.sh

ENV PATH="$PATH:/gh-runner/bin"

#RUN adduser --no-create-home ghrunner -uid 1001
RUN adduser ghrunner -uid 1001
RUN chown -R ghrunner:ghrunner /gh-runner
RUN chmod 777 /gh-runner
RUN chmod 777 /home/ghrunner
RUN mkdir /ghrunner
RUN chmod 777 /ghrunner
USER ghrunner

RUN pipx install awscli && pipx ensurepath
RUN cp /home/ghrunner/.local/bin/aws* /gh-runner/bin

COPY cadence.tfrc /home/ghrunner/

EXPOSE 3000
ENTRYPOINT ["/gh-runner/entrypoint.sh"]
