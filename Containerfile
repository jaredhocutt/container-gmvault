# https://catalog.redhat.com/software/containers/ubi8/ubi/5c359854d70cc534b3a3784e
FROM registry.access.redhat.com/ubi8/ubi:8.6

ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV GMVAULT_DIR="/data" \
    GMVAULT_EMAIL_ADDRESS="user@example.com" \
    GMVAULT_SYNC_TYPE="quick"

USER root

VOLUME $GMVAULT_DIR
WORKDIR /app

RUN yum install -y \
    python2 \
    python2-pip \
    && pip2 install --upgrade pip \
    && pip2 install gmvault==1.9.1 \
    && yum clean all \
    && echo 'export PS1="\n\[\e[34m\]\u\[\e[m\] at \[\e[32m\]\h\[\e[m\] in \[\e[33m\]\w\[\e[m\] \[\e[31m\]\n\\$\[\e[m\] "' >> /root/.bashrc

# Patch to support large mailboxes
RUN sed -i '/^import imaplib/a imaplib._MAXLINE = 10000000' $(find / -name 'imapclient.py')

COPY src ./

ENTRYPOINT ["/app/entrypoint.sh"]
