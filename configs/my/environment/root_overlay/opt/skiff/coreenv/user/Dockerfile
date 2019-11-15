# This is automatically changed to arm32v6/ubuntu (for example).
FROM ubuntu:bionic

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV TERM xterm
ENV container docker

# Core packages
RUN apt-get update && \
  apt-get dist-upgrade -y && \
  apt-get install -y \
  openssh-client \
  vim \
  rsync \
  build-essential \
  lsb-release \
  systemd \
  mosh \
  usbutils \
  sudo \
  curl \
  htop \
  less \
  nano \
  net-tools \
  software-properties-common \
  unzip \
  autotools-dev \
  wget && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

# Add docker in docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg |\
  sudo apt-key add - && \
  sudo add-apt-repository -y \
    "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
  apt-get update && \
  apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io && \
  systemctl enable docker && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

# Create the user 'core' which will be the usual userspace account
# Also allow core to run stuff as sudo without a password.
ADD ./init-home.sh /opt/skiff-core/scripts/init-home.sh
RUN \
  adduser core \
  --no-create-home \
  --gecos "Core" \
  --shell /bin/bash \
  --disabled-password && \
  adduser core sudo && \
  adduser core root && \
  adduser core dialout && \
  adduser core plugdev && \
  mkdir -p /home/core/ && \
  chown core:core /home/core && \
  chmod +x /opt/skiff-core/scripts/init-home.sh && \
  echo "core    ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

ADD ./init-home-core.service /etc/systemd/system
RUN systemctl set-default multi-user.target && \
    systemctl enable init-home-core.service && \
    systemctl mask tmp.mount && \
    find /etc/systemd/system \
         /lib/systemd/system \
         \( -path '*.wants/*' \
         -name '*swapon*' \
         -or -name '*ntpd*' \
         -or -name '*resolved*' \
         -or -name '*udev*' \
         -or -name '*kmod-static*' \
         -or -name '*freedesktop*' \
         -or -name '*persist-resize*' \
         -or -name '*remount-fs*' \
         -or -name '*getty*' \
         -or -name '*systemd-sysctl*' \
         -or -name '*.mount' \
         -or -name '*remote-fs*' \) \
         -exec echo \{} \; \
         -exec rm \{} \;

ADD ./fstab /etc/fstab
ADD ./docker.json /etc/docker/daemon.json

WORKDIR /home/core
VOLUME ["/sys/fs/cgroup", "/tmp", "/run", "/run/lock"]
ENTRYPOINT ["/lib/systemd/systemd"]

