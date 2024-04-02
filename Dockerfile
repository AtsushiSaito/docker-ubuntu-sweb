ARG TARGET_TAG
FROM ubuntu:${TARGET_TAG}

ENV DEBIAN_FRONTEND noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
ARG TARGETARCH

####################
# Upgrade
####################
RUN apt-get update -q \
    && apt-get upgrade -y \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
    
####################
# Add Ubuntu Mate
####################
RUN apt-get update -q \
    && apt-get upgrade -y \
    && apt-get install -y \
        ubuntu-mate-desktop \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

####################
# Add Package
####################
RUN apt-get update \
    && apt-get install -y \
        supervisor wget gosu git sudo python3-pip \
        libswitch-perl libyaml-tiny-perl \
        libhash-merge-simple-perl libdatetime-timezone-perl\
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
RUN wget -O turbovnc.deb https://jaist.dl.sourceforge.net/project/turbovnc/3.0/turbovnc_3.0_${TARGETARCH}.deb \
    && dpkg -i turbovnc.deb && rm -rf turbovnc.deb

####################
# Add User
####################
ENV USER ubuntu
ENV PASSWD ubuntu
RUN useradd --home-dir /home/$USER --shell /bin/bash --create-home --user-group --groups adm,sudo,ssl-cert $USER
RUN echo $USER:$USER | /usr/sbin/chpasswd

####################
# KasmVNC
####################
RUN wget https://github.com/kasmtech/KasmVNC/releases/download/v1.3.0/kasmvncserver_jammy_1.3.0_amd64.deb \
    && apt-get install ./kasmvncserver_jammy_1.3.0_amd64.deb -y
RUN mkdir -p /home/$USER/.vnc \
    && gosu ubuntu bash -c 'echo -e "ubuntu\nubuntu\n" | vncpasswd -u ubuntu -w -r' \
    && chown -R $USER:$USER /home/$USER

####################
# Disable Update and Crash Report
####################
RUN sed -i 's/Prompt=.*/Prompt=never/' /etc/update-manager/release-upgrades
RUN sed -i 's/enabled=1/enabled=0/g' /etc/default/apport

####################
# Supervisor
####################
ENV CONF_PATH /etc/supervisor/conf.d/supervisord.conf
RUN echo '[supervisord]' >> $CONF_PATH \
    && echo 'nodaemon=true' >> $CONF_PATH \
    && echo 'user=root'  >> $CONF_PATH \
    && echo '[program:kasmvnc]' >> $CONF_PATH \
    && echo 'command=gosu '$USER' /usr/bin/vncserver -select-de mate' >> $CONF_PATH
CMD ["bash", "-c", "supervisord -c $CONF_PATH"]