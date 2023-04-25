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
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e[34m>>>>>>>>>>>>>>>>>Unzipo App content<<<<<<<<<<<<<<<<<<<\e[0m"
unzip /tmp/cart.zip

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install NodeJS Dependencies<<<<<<<<<<<<<<<<<<<\e[0m"
npm install

echo -e "\e[34m>>>>>>>>>>>>>>>>>Copy cart systemd file<<<<<<<<<<<<<<<<<<<\e[0m"
cp  /home/centos/Roboshop-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[34m>>>>>>>>>>>>>>>>>Start cart Service<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart
echo "You need to update cart server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf"