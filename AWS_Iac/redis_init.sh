#!/bin/bash

sudo yum update -y

sudo yum install -y git curl

sudo amazon-linux-extras install docker -y

sudo service docker start

sudo docker run -d -p 6379:6379 redis
