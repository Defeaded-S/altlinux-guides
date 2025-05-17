#!/bin/bash
cd ~/
apt-get install -y git apt-repo-tools nginx
wait
git clone https://github.com/Defeaded-S/altlinux-guides.git
wait
mkdir -p /var/www/html/altlinux
cd /var/www/html/altlinux
cat ~/altlinux-guides/create.sh | bash
cat ~/altlinux-guides/meta.sh | bash
wait
cp ~/altlinux-guides/altlinux.conf /etc/nginx/sites-available.d/
ln -s /etc/nginx/sites-available.d/altlinux.conf /etc/nginx/sites-enabled.d/altlinux.conf
systemctl enable --now nginx
wait
apt-get install -y /usr/bin/packages
