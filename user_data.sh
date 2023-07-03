#! /bin/bash    

sudo yum update -y && sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo echo '<h1>Hey there! Welcome to the web server</h1>' | sudo tee /var/html/index.html 
