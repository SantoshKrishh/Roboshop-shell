
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip
npm install
cp cart.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart
systemctl start cart
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb.vintagevings.ga </app/schema/user.js
echo "You need to update cart server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf"