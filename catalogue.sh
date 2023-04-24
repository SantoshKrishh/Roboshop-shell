echo -e "\e[34m>>>>>>>>>>>>>>>>>Configuring Node JS repos<<<<<<<<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install NodeJS<<<<<<<<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[34m>>>>>>>>>>>>>>>>> Add Application user<<<<<<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[34m>>>>>>>>>>>>>>>>>Create Application Directory<<<<<<<<<<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[34m>>>>>>>>>>>>>>>>>Download Application Content<<<<<<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

echo -e "\e[34m>>>>>>>>>>>>>>>>>Extract Application Content<<<<<<<<<<<<<<<<<<<\e[0m"
unzip /tmp/catalogue.zip

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install NodeJS Dependencies<<<<<<<<<<<<<<<<<<<\e[0m"
npm install

echo -e "\e[34m>>>>>>>>>>>>>>>>>Copy catalogue systemd file<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[34m>>>>>>>>>>>>>>>>>Start catalogue Service<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

echo -e "\e[34m>>>>>>>>>>>>>>>>>copy mongodb repo<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install MongoDB Client <<<<<<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Load MongoDB Schema<<<<<<<<<<<<<<<<<<<\e[0m"
mongo --host mongodb.vintagevings.ga </app/schema/catalogue.js
echo "You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf"