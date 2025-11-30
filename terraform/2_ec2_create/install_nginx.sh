#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "<h1>Terraform is used to CREATE CLOUD INFRASTRUCTURE </h1>" | sudo tee /var/www/html/index.html 