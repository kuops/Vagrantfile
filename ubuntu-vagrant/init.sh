#!/bin/bash

#replace apt sources to aliyun
sed -i 's@archive.ubuntu.com@mirrors.aliyun.com@g' /etc/apt/sources.list
sed -i 's@security.ubuntu.com@mirrors.aliyun.com@g' /etc/apt/sources.list

#upgrade apt
apt-get update

#install required soft
apt-get install -y pv git tmux htop iotop fabric gettext subversion expect realpath build-essential apache2-utils mysql-client-core-5.7 mysql-client-5.7 build-essential libpango1.0-0 libcairo2 libssl-dev libffi-dev libevent-dev libjpeg-dev libmemcached-dev libmysqlclient-dev libpng12-dev libpq-dev libxml2-dev libxslt1-dev libfreetype6-dev libssl-dev libffi-dev zlib1g-dev unixodbc-dev python-dev python-pip python-git python-imaging python-redis python-virtualenv

#upgrade pip setuptools
sudo pip install --upgrade pip setuptools

#install ansible
sudo pip install ansible

#install docker
apt-get remove docker docker-engine docker.io

apt-get update   

curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -
  
add-apt-repository \
"deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu/ \
$(lsb_release -cs) \
stable"

apt-get update
apt-get install -y docker-ce
usermod -aG docker vagrant

mkdir -p /etc/docker/
cat <<'EOF'> /etc/docker/daemon.json
{
  "registry-mirrors": ["https://fz5yth0r.mirror.aliyuncs.com"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  }
}
EOF

systemctl start docker
systemctl enable docker
#install required soft for pip
sudo pip install uwsgi supervisor newrelic
