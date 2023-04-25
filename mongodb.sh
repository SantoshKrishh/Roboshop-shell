source common.sh

echo -e "\e[34m>>>>>>>>>>>>>>>>>Copying Mongo Repo file<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[34m>>>>>>>>>>>>>>>>>Installing MongoDB<<<<<<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Updating listen address<<<<<<<<<<<<<<<<<<<\e[0m"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf

echo -e "\e[34m>>>>>>>>>>>>>>>>>Restart the service<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl restart mongod


echo "You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf"

