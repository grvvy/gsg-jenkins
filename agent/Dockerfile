# Base image
FROM jenkins/agent
USER root

# Create 'docker' group that reflects the host machine and add user jenkins to it
ARG DOCKER_GROUP_ID
RUN groupadd -g $DOCKER_GROUP_ID docker && usermod -a -G docker jenkins

# Install prerequisites
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

EXPOSE 8080
USER jenkins
