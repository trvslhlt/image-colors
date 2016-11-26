#!/bin/sh


# act as super user
sudo su -


# install tools
apt-get update
apt-get -y install git
apt-get -y install nginx
apt-get -y install golang-go
apt-get -y install imagemagick


# configure go environment
export GOPATH=/usr/share/go
export GOBIN=$GOPATH/bin
echo "export GOPATH=$GOPATH" >> .profile
echo "export GOBIN=$GOBIN" >> .profile


# get go app dependencies
go get github.com/gorilla/mux
go get github.com/gorilla/handlers
go get github.com/asaskevich/govalidator


# prepare app
cp /vagrant/image-colors-app/image-colors-app.go /home/vagrant/image-colors-app.go
go build image-colors-app.go


# web server
cp /vagrant/nginx_sites_enabled_default /etc/nginx/sites-enabled/default
service nginx restart
echo "need to add nginx to supervisor"


# process management tool
apt-get -y install supervisor
addgroup --system supervisor
adduser vagrant supervisor
cp /vagrant/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
cp /vagrant/supervisor/image-colors-app.conf /etc/supervisor/conf.d/image-colors-app.conf
service supervisor restart
supervisorctl reload
