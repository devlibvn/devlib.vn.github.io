# Ubuntu commands
## Docker
[Tài liệu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

```bash
#
sudo apt-get update
#
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
#
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#
sudo apt-key fingerprint 0EBFCD88
#
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
#
sudo apt-get update
#
sudo apt-get install docker-ce docker-ce-cli containerd.io
#
sudo docker run hello-world
#
sudo gpasswd -a $USER docker
```

## Docker Compose
[Tài liệu](https://docs.docker.com/compose/install/)

```bash
#
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#
sudo chmod +x /usr/local/bin/docker-compose
#
docker-compose --version
```

## SSL
[Tài liệu](https://certbot.eff.org)

```bash
#install
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot python-certbot-nginx

#check port
netstat -ln
#kill process on port 80 if exists
sudo kill `sudo lsof -t -i:80`
#register
sudo certbot certonly --standalone -d domain.com www.domain.com
#automating renewnal
sudo certbot renew --dry-run
```

## rclone
[Tài liệu](https://rclone.org/install/)
1. Cài đặt

```bash
# To install rclone on Linux/macOS/BSD systems, run:
curl https://rclone.org/install.sh | sudo bash

```

### Google drive
[Tài liệu](https://rclone.org/drive/)

## Mongodb
[Tài liệu](https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-18-04)

1. Cài đặt

```bash
# Installing MongoDB
sudo apt update
sudo apt install -y mongodb
# Checking the Service and Database
sudo systemctl status mongodb
# mongo --eval 'db.runCommand({ connectionStatus: 1 })'
# Managing the MongoDB Service
# verify the status of the service
sudo systemctl status mongodb
# stop the server anytime
sudo systemctl stop mongodb
# start the server when it is stopped
sudo systemctl start mongodb
# restart the server with a single command
sudo systemctl restart mongodb
# MongoDB is configured to start automatically with the server. If you wish to disable the automatic startup
sudo systemctl disable mongodb
# It's just as easy to enable it again
sudo systemctl enable mongodb
```

2. Configuration

Default configuration file: `/etc/mongodb.conf`

Default data: `/var/lib/mongodb`

Default logs: `/var/logs/mongodb/mongodb.log`

3. Authentication

Tạo User Administrator
[Tài liệu](https://docs.mongodb.com/manual/tutorial/enable-authentication/)
```bash
# Start MongoDB without access control
mongod --port 27017 --dbpath /data/db1
# Connect to the instance
mongo --port 27017
# Create the user administrator
use admin
db.createUser(
  {
    user: "myUserAdmin",
    pwd: "abc123",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
  }
)
# Re-start the MongoDB instance with access control
mongod --auth --port 27017 --dbpath /data/db1
# Connect and authenticate as the user administrator
# To authenticate during connection
mongo --port 27017 -u "myUserAdmin" -p "abc123" --authenticationDatabase "admin"
# To authenticate after connecting
mongo --port 27017
use admin
db.auth("myUserAdmin", "abc123" )
# --------------------------------------------------------
# Create additional users as needed for your deployment
use test
db.createUser(
  {
    user: "myTester",
    pwd: "xyz123",
    roles: [ { role: "readWrite", db: "test" },
             { role: "read", db: "reporting" } ]
  }
)
```

4. Automatic backup
