# Создание локального репозитория Altlinux
### Клонируем репозиторий
```
cd ~/
apt-get install -y git
git clone https://github.com/Defeaded-S/altlinux-guides.git
```
### Создаем каталог репозитория:
```
mkdir -p /var/www/html/altlinux
```
### Создаем структуру репозитория скриптом create.sh
```
mv ~/altlinux-guides/create.sh /var/www/html/altlinux/
cd /var/www/html/altlinux
./create.sh
```
### Устанавливаем nginx
```
apt-get install -y nginx
systemctl enable -now nginx
```
### Настраиваем http доступ до репозитория
```
mv ~/altlinux-guides/altlinux.conf /etc/nginx/sites-available.d/
ln -s /etc/nginx/sites-available.d/altlinux.conf /etc/nginx/sites-enabled.d/altlinux.conf
systemctl restart nginx
```
### Добавление пакетов в репозиторий
```
cd ~/altlinux-guides
apt-get install -d <название пакета>
./addpackages.sh /var/www/html/altlinux classic /var/cache/apt/archives/
./meta.sh /var/www/html/altlinux classic
```
### Замена репозиториев на свой
```
apt-repo rm all
apt-repo add rpm http://<IP>/altlinux x86_64 classic
apt-repo add rpm http://<IP>/altlinux noarch classic
apt-repo add rpm http://<IP>/altlinux i586 classic
```
