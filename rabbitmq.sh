source common.sh

dirname $0

exit

echo -e "\e[34m>>>>>>>>>>>>>>>>>Setup Erlang Repos<<<<<<<<<<<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[34m>>>>>>>>>>>>>>>>>Setup RabbitMQ Repos<<<<<<<<<<<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[34m>>>>>>>>>>>>>>>>>Install Erlang & RabbitMQ<<<<<<<<<<<<<<<<<<<\e[0m"
yum install erlang rabbitmq-server -y

echo -e "\e[34m>>>>>>>>>>>>>>>>>Add Application user in RabbitMQ<<<<<<<<<<<<<<<<<<<\e[0m"
rabbitmqctl add_user ${app_user} roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

echo -e "\e[34m>>>>>>>>>>>>>>>>>Start RabbitMQ Service<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server



