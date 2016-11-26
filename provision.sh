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


# configure web server
# cp /vagrant/nginx_sites_enabled_default /etc/nginx/sites-enabled/default
# service nginx restart

# configure process management tool
# addgroup --system supervisor
# adduser vagrant supervisor
# cp /vagrant/supervisord.conf /etc/supervisor/supervisord.conf
# cp /vagrant/app_supervisor.conf /etc/supervisor/conf.d/app.conf
# supervisorctl reload
