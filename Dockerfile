ARG TARGET_TAG
FROM ubuntu:${TARGET_TAG}

ENV DEBIAN_FRONTEND noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Upgrade
RUN apt-get update -q \
    && apt-get upgrade -y \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
    
# Add Ubuntu MATE
RUN apt-get update -q \
    && apt-get upgrade -y \
    && apt-get install -y \
        ubuntu-mate-desktop \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Add Package
RUN apt-get update \
    && apt-get install -y \
        tigervnc-standalone-server tigervnc-common \
        supervisor wget curl gosu git sudo python3-pip \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Add User
ENV USER ubuntu
ENV PASSWD ubuntu
RUN useradd -m -s /bin/bash -G adm,sudo $USER 2>/dev/null || usermod -aG adm,sudo $USER
RUN echo $USER:$USER | /usr/sbin/chpasswd
RUN mkdir -p /home/$USER/.vnc \
    && echo $PASSWD | vncpasswd -f > /home/$USER/.vnc/passwd \
    && chmod 600 /home/$USER/.vnc/passwd \
    && chown -R $USER:$USER /home/$USER

# noVNC and Websockify
RUN git clone https://github.com/AtsushiSaito/noVNC.git -b add_clipboard_support /usr/lib/novnc
RUN PIP_BREAK_SYSTEM_PACKAGES=1 pip install git+https://github.com/novnc/websockify.git@v0.10.0
RUN sed -i "s/password = WebUtil.getConfigVar('password');/password = '$PASSWD'/" /usr/lib/novnc/app/ui.js
RUN mv /usr/lib/novnc/vnc.html /usr/lib/novnc/index.html

# Disable Update and Crash Report
RUN sed -i 's/Prompt=.*/Prompt=never/' /etc/update-manager/release-upgrades
RUN sed -i 's/enabled=1/enabled=0/g' /etc/default/apport

# Supervisor
ENV CONF_PATH /etc/supervisor/conf.d/supervisord.conf
RUN echo '[supervisord]' >> $CONF_PATH \
    && echo 'nodaemon=true' >> $CONF_PATH \
    && echo 'user=root'  >> $CONF_PATH \
    && echo '[program:vnc]' >> $CONF_PATH \
    && echo 'command=gosu '$USER' bash -c "vncserver :1 -fg -geometry 1920x1080 -depth 24"' >> $CONF_PATH \
    && echo '[program:novnc]' >> $CONF_PATH \
    && echo 'command=gosu '$USER' bash -c "websockify --web=/usr/lib/novnc 80 localhost:5901"' >> $CONF_PATH
CMD ["bash", "-c", "supervisord -c $CONF_PATH"]