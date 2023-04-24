echo -e "\e[34m>>>>>>>>>>>>>>>>>Install Nginx<<<<<<<<<<<<<<<<<<<\e[0m"
yum install nginx -y
# roboshop.conf file is created separately in git repo and is made to be copied to desired dir in the instance

echo -e "\e[34m>>>>>>>>>>>>>>>>>Copying Roboshop Configuration file <<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[34m>>>>>>>>>>>>>>>>>Removing web server default content<<<<<<<<<<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[34m>>>>>>>>>>>>>>>>>Extracting frontend content.<<<<<<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[34m>>>>>>>>>>>>>>>>>Restarting Nginx Service<<<<<<<<<<<<<<<<<<<\e[0m"
 systemctl enable nginx
 systemctl restart nginx

 echo "Ensure you replace the localhost with the actual ip address of those component server. Word localhost is just used to avoid the failures on the Nginx Server."