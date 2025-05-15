FROM ubuntu:latest
MAINTAINER Corbin Uselton <corbinu@decimal.io>


ARG PUB_KEY=${PUB_KEY}
ENV TERM xterm
ENV PUB_KEY=${PUB_KEY}


RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd #\
#  && mkdir /root/.ssh \
#  && chmod 700 /root/.ssh \
#  && echo "$PUB_KEY" > /root/.ssh/authorized_keys

COPY bin/* /usr/local/bin/
COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["ssh-start"]
CMD ["ssh-server"]
