FROM ubuntu:18.04

# ARGUMENTS
#ARG SDK_MANAGER_VERSION=0.9.14-4964
ARG SDK_MANAGER_VERSION=1.1.0-6343
ARG SDK_MANAGER_DEB=sdkmanager_${SDK_MANAGER_VERSION}_amd64.deb

# add new sudo user
USER root
ENV USERNAME jetpack
ENV HOME /home/$USERNAME
ENV HOSTNAME ubuntu64vm

RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        mkdir /etc/sudoers.d && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        usermod  --uid 1000 $USERNAME && \
        groupmod --gid 1000 $USERNAME

# install package
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get install -y --no-install-recommends \
	sudo \
        build-essential \
	binfmt-support \
	qemu-user-static \
        apt-utils

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
	vim \
        tzdata \
        git \
        bash-completion \
        command-not-found \
        libgconf-2-4 \
        libcanberra-gtk-module \
        libcanberra-gtk3-module \
        libgtk-3-0 \
        libx11-xcb1 \
        libxss1 \
        libnss3 \
        libxtst6 \
        libopencv-dev \
        python \
        sshpass \
        less \
        net-tools \
        usbutils \
        locales \
        netcat-traditional \
        netcat-openbsd \
        openssh-client \
        iproute2 \
        iptables \
        dnsutils \
        gpg \
        gpg-agent \
        gpgconf \
        gpgv \
        inetutils-ping \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# set locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

#RUN sh -c 'echo 127.0.1.1 $HOSTNAME >> /etc/hosts'

# install SDK Manager
USER jetpack
COPY ${SDK_MANAGER_DEB} /home/${USERNAME}/
#COPY spawn_sdk_manager.sh /home/${USERNAME}/

# prepare for mapping host 'Downloads' folder
WORKDIR /home/${USERNAME}
RUN rm -rf /home/${USERNAME}/Downloads
RUN sudo apt-get install -f /home/${USERNAME}/${SDK_MANAGER_DEB}

# change prompt text color
RUN sed -i -e 's/#force_color_prompt=/force_color_prompt=/' .bashrc
RUN sed -i -e 's/\\\[\\033\[01;32m\\\]\\u@\\h/\\\[\\033\[01;36m\\\]\\u@\\h/g' .bashrc

USER root
RUN echo "${USERNAME}:${USERNAME}" | chpasswd

RUN rm /home/${USERNAME}/${SDK_MANAGER_DEB}
