FROM jenkins/inbound-agent
ENV HOME /home/jenkins/agent

# User- & Group-ID same as in the hostsystem. also docker-group ID
ARG PUID=1000
ARG PGID=1000
ARG DOCKER_PGID=998

USER root

# Add jenkins-user (owner to mount-files is the same as in the hostsystem)
RUN groupmod -g ${PGID} jenkins
RUN usermod -u ${PUID} jenkins

# Add Docker group to user (access to docker.sock)
RUN groupadd -g ${DOCKER_PGID} docker
RUN usermod -a -G docker jenkins

WORKDIR /home/jenkins/agent
USER jenkins

# docker build -t jenkins-inbound-agent-dind --build-arg PUID=$(id -u)  --build-arg PGID=$(id -g) --build-arg DOCKER_PGID=$(stat -c "%g" /var/run/docker.sock) .
