#!/bin/sh

sudo su -

apt-get update
apt-get -y install git
apt-get -y install nginx
apt-get -y install golang-go
apt-get -y install imagemagick

cp /vagrant/nginx_sites_enabled_default /etc/nginx/sites-enabled/default
sudo service nginx restart

echo "export GOPATH=/usr/share/go/" >> .profile
echo "export GOBIN=$GOPATH/bin" >> .profile
echo "export PATH=$GOPATH/bin:$PATH" >> .profile
. ~/.profile

go get github.com/gorilla/mux
go get github.com/gorilla/handlers
go get github.com/asaskevich/govalidator
