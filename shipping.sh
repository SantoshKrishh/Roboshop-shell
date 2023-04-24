yum install maven -y
useradd roboshop
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar
cp shipping.serice /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
yum install mysql -y
mysql -h mysql.vintagevings.ga -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping
echo "You need to update shipping server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf"