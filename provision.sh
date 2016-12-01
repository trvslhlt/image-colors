#!/bin/sh


# act as super user
sudo su -


# install tools
apt-get update
apt-get -y install git
apt-get -y install golang-go
apt-get -y install imagemagick
apt-get -y install supervisor


# # configure go environment
export GOPATH=/usr/share/go
export GOBIN=$GOPATH/bin
echo "export GOPATH=$GOPATH" >> .profile
echo "export GOBIN=$GOBIN" >> .profile


# # get go app dependencies
go get github.com/gorilla/mux
go get github.com/gorilla/handlers
go get github.com/asaskevich/govalidator


# setup application
cp -r ./go_application/main.go .
go build main.go


# setup process manager
addgroup --system supervisor
adduser vagrant supervisor
cp ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
cp ./supervisor/main.conf /etc/supervisor/conf.d/main.conf
sudo systemctl enable supervisor
service supervisor restart
supervisorctl reload
