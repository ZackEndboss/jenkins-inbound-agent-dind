# jenkins-inbound-agent-dind
jenkins/inbound-agent including docker

# How to build
docker build -t jenkins-inbound-agent-dind --build-arg PUID=$(id -u)  --build-arg PGID=$(id -g) --build-arg DOCKER_PGID=$(stat -c "%g" /var/run/docker.sock) .

# How to run
docker run \
  --init \
  -e JENKINS_WEB_SOCKET=true \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/bin/docker \
  jenkins-inbound-agent-dind -url http://jenkins-server:port -workDir=/home/jenkins/agent <secret> <agent name>

# Optional
There are several options to use. Take a look at: https://github.com/jenkinsci/docker-inbound-agent like workDir or JENKINS_WEB_SOCKET.

# Docker
To use docker, you need to add the following mounts:
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/bin/docker \
