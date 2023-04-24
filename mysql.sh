
echo -e "\e[34m>>>>>>>>>>>>>>>>>Disable Mysql 8 Version<<<<<<<<<<<<<<<<<<<\e[0m"
dnf module disable mysql -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Disable Mysql Repo File<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install Mysql<<<<<<<<<<<<<<<<<<<\e[0m"
yum install mysql-community-server -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>start Mysql SystemD<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[34m>>>>>>>>>>>>>>>>>Reset Mysql Password<<<<<<<<<<<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
