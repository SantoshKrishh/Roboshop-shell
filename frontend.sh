set-hostname frontend
yum install nginx -y
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

# roboshop.conf file needs to be created

 systemctl enable nginx
 systemctl start nginx