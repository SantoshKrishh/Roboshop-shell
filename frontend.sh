
yum install nginx -y
# roboshop.conf file is created separately in git repo and is made to be copied to desired dir in the instance

cp roboshop.conf /etc/nginx/default.d/roboshop.conf
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
 systemctl enable nginx
 systemctl start nginx

 echo "Ensure you replace the localhost with the actual ip address of those component server. Word localhost is just used to avoid the failures on the Nginx Server."