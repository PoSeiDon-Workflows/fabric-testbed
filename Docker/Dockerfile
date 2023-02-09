FROM python:3.9-buster

ARG FABLIB_VERSION
ARG FABRIC_USER_ID
ARG FABRIC_USER_GROUP_ID

ENV USER "fabric"
ENV USER_ID ${FABRIC_USER_ID}
ENV USER_GROUP "fabric"
ENV USER_GROUP_ID ${FABRIC_USER_GROUP_ID}
ENV HOME "/home/${USER}"

ENV FABRIC_CREDMGR_HOST=cm.fabric-testbed.net
ENV FABRIC_ORCHESTRATOR_HOST=orchestrator.fabric-testbed.net

RUN apt-get update \
    && apt-get install -y apt-utils git vim cron \
    && apt-get -y upgrade 

ADD crontab /etc/crontab
RUN chmod 0644 /etc/crontab
RUN crontab /etc/crontab

#### Add "fabric" user matching my user's id/gid ####
RUN useradd -d ${HOME} -s /bin/bash -u ${USER_ID} -m ${USER}

USER fabric
WORKDIR ${HOME}

ENV PATH=${HOME}/.local/bin:${PATH}

RUN mkdir ${HOME}/work && pip3 install --upgrade pip \
    && pip3 install python-chi fabrictestbed fabrictestbed_extensions==${FABLIB_VERSION} jupyter jupyterlab paramiko bash_kernel pandas \ 
    && python -m bash_kernel.install

WORKDIR ${HOME}/work

RUN git clone https://github.com/fabric-testbed/jupyter-examples.git
COPY entrypoint.sh /opt/entrypoint.sh
COPY cron-entrypoint.sh /opt/cron-entrypoint.sh
