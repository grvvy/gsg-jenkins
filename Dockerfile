# Base image
FROM jenkins/jenkins:2.339
USER root

# Create 'docker' group that reflects the host machine and add user 'jenkins' to it
ARG DOCKER_GROUP_ID
RUN groupadd -g $DOCKER_GROUP_ID docker && usermod -a -G docker jenkins

# Automate jenkins setup by disabling the setup wizard and pointing to
# the configuration files to install from and setup with
RUN mkdir /startup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /startup/config.yaml
COPY /startup/plugins.txt /startup/plugins.txt
RUN jenkins-plugin-cli --plugin-file /startup/plugins.txt
COPY /startup/config.yaml /startup/config.yaml
COPY /startup/job.groovy /startup/job.groovy

# Install prerequisites/docker
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
