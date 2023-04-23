
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
systemctl enable mongod
systemctl start mongod

# mongo.conf needs to be edited to Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf