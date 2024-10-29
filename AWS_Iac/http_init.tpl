#!/bin/bash

sudo yum update -y

sudo yum install -y git curl

sudo amazon-linux-extras install docker -y

sudo service docker start

sudo docker run --name my_app_container \
           -e DB_HOST="${db_host}" \
           -e DB_USER="${db_user}" \
           -e DB_PASSWORD="${db_password}" \
           -e DB_NAME="${db_name}" \
           -e REDIS_HOST="${redis_host}" \
           -v ./data:/var/lib/mysql \
           -p 5000:5000 -d haldekhiel/capstone-project-1:latest
