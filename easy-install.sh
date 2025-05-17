#!/bin/bash
cd ~/
apt-get install -y git
git clone https://github.com/Defeaded-S/altlinux-guides.git
mkdir -p /var/www/html/altlinux
mv ~/altlinux-guides/create.sh /var/www/html/altlinux/
cd /var/www/html/altlinux
./create.sh
apt-get install -y nginx
systemctl enable -now nginx
mv ~/altlinux-guides/altlinux.conf /etc/nginx/sites-available.d/
ln -s /etc/nginx/sites-available.d/altlinux.conf /etc/nginx/sites-enabled.d/altlinux.conf
systemctl restart nginx
apt-get install /usr/bin/packages
cd ~/altlinux-guides
