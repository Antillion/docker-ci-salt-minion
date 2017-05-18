FROM        ubuntu:14.04
LABEL maintainer "otupman@antillion.com"
LABEL vendor "Antillion Ltd"
LABEL architecture "x86_64"
LABEL name "ci-salt-minion"

ENV SALT_VERSION=2016.3.0 \
      SALTMASTER=saltmaster \
     MINION_NAME=ci_minion \
   SALT_PASSWORD=59r{Y3*912

RUN apt-get update && apt-get install -y curl wget

RUN wget -O install_salt.sh https://bootstrap.saltstack.com

# Exit 0 below is a hack for https://github.com/saltstack/salt-bootstrap/issues/394#issuecomment-71263471
RUN sh install_salt.sh -X -I -i $MINION_NAME -A $SALTMASTER git v$SALT_VERSION; exit 0
RUN mkdir /var/log/salt

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo "root:$SALT_PASSWORD" |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

ADD etc/init/salt-minion.conf /etc/init/salt-minion.conf
ADD etc/init.d/salt-minion /etc/init.d/salt-minion
ADD start.sh /start.sh

EXPOSE 22

CMD /start.sh
