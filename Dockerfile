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

EXPOSE 8080
USER jenkins
