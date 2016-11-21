sudo su -

apt-get update
apt-get -y install git
apt-get -y install golang-go
apt-get -y install imagemagick 

echo "export GOPATH=\"/usr/share/go/\"" >> .profile
. .profile

go get github.com/gorilla/mux
go get github.com/gorilla/handlers
go get github.com/asaskevich/govalidator
