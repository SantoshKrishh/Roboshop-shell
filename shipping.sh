
echo -e "\e[34m>>>>>>>>>>>>>>>>>Install Maven<<<<<<<<<<<<<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Create App User<<<<<<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[34m>>>>>>>>>>>>>>>>>Create App Directory<<<<<<<<<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[34m>>>>>>>>>>>>>>>>>Download App Content<<<<<<<<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

echo -e "\e[34m>>>>>>>>>>>>>>>>>Extract App Content<<<<<<<<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/shipping.zip

echo -e "\e[34m>>>>>>>>>>>>>>>>>Download Maven Dependencies<<<<<<<<<<<<<<<<<<<\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install Mysql<<<<<<<<<<<<<<<<<<<\e[0m"
yum install mysql -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Load Schema<<<<<<<<<<<<<<<<<<<\e[0m"
mysql -h mysql.vintagevings.ga -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[34m>>>>>>>>>>>>>>>>>Start Shipping Service<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/shipping.serice /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
echo "You need to update shipping server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf"