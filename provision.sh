#!/bin/sh


# act as super user
sudo su -


# install tools
apt-get update
apt-get -y install git
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

# setup application
cp -r /vagrant/go_application/ ./go_application
go build go_application/*
