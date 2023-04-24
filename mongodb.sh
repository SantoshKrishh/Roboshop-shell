
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf
systemctl enable mongod
systemctl start mongod


echo "You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf"