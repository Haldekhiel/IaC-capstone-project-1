#!/bin/bash

sudo yum update -y

sudo yum install -y curl

sudo amazon-linux-extras install docker -y

sudo service docker start

sudo docker run -e MYSQL_DATABASE="${mysql_database}" \
           -e MYSQL_ROOT_PASSWORD="${mysql_root_password}" \
           -p 3306:3306 -v ./data:/var/lib/mysql -d mysql
