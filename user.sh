source common.sh

echo -e "\e[34m>>>>>>>>>>>>>>>>>Setting NodeJS repos<<<<<<<<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo "\e[34m>>>>>>>>>>>>>>>>>Install NodeJS<<<<<<<<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Adding Application user<<<<<<<<<<<<<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[34m>>>>>>>>>>>>>>>>>Creating User<<<<<<<<<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[34m>>>>>>>>>>>>>>>>>Downloading App content<<<<<<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[34m>>>>>>>>>>>>>>>>>Unzipo App content<<<<<<<<<<<<<<<<<<<\e[0m"
unzip /tmp/user.zip

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install NodeJS Dependencies<<<<<<<<<<<<<<<<<<<\e[0m"
npm install

echo -e "\e[34m>>>>>>>>>>>>>>>>>Copy user systemd file<<<<<<<<<<<<<<<<<<<\e[0m"
cp  /home/centos/Roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[34m>>>>>>>>>>>>>>>>>Start user Service<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

echo -e "\e[34m>>>>>>>>>>>>>>>>>copy mongodb repo<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install MongoDB Client <<<<<<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Load MongoDB Schema<<<<<<<<<<<<<<<<<<<\e[0m"
mongo --host mongodb.vintagevings.ga </app/schema/user.js
echo "You need to update user server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf"