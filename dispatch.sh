source common.sh

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install Golang<<<<<<<<<<<<<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Create Application user<<<<<<<<<<<<<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[34m>>>>>>>>>>>>>>>>>Create Application Dir<<<<<<<<<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[34m>>>>>>>>>>>>>>>>>Download  Configuration files<<<<<<<<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e[34m>>>>>>>>>>>>>>>>>Unzipping files<<<<<<<<<<<<<<<<<<<\e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install dependencies & build the software.<<<<<<<<<<<<<<<<<<<\e[0m"
go mod init dispatch
go get
go build

echo -e "\e[34m>>>>>>>>>>>>>>>>>Copying service files<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[34m>>>>>>>>>>>>>>>>>Starting services<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch