sudo su -

apt-get update
apt -y install git
apt -y install golang-go

echo "export GOPATH=\"/usr/share/go/\"" >> .profile
. .profile

go get github.com/gorilla/mux
go get github.com/gorilla/handlers
go get github.com/asaskevich/govalidator
