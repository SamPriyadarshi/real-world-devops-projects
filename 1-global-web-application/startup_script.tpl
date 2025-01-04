#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo service apache2 restart
sudo mkdir -p /var/www/html
sudo gsutil -m cp -r gs://${bucket_name}/* /var/www/html/
