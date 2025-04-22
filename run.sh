#!/bin/bash

git clone "https://github.com/Revanthsatyam/$component.git"

aws_ssm() {
  aws ssm get-parameter --name "$1" --with-decryption --query "Parameter.Value" --output text
}

if [ "${schema_type}" == "DOCDB" ]; then
  mongo_host=$(aws_ssm docdb.$env.endpoint)
  user_name=$(aws_ssm docdb.$env.master_username)
  password=$(aws_ssm docdb.$env.master_password)

  mongo --ssl --host $mongo_host:27017 --sslCAFile /rds-combined-ca-bundle.pem --username $user_name --password $password <$component/schema/$component.js
fi

if [ "${schema_type}" == "MYSQL" ]; then
  mysql_host=$(aws_ssm rds.$env.endpoint)
  user_name=$(aws_ssm rds.$env.master_username)
  password=$(aws_ssm rds.$env.master_password)

  mysql -h $mysql_host -u$user_name -p$password <$component/schema/$component.sql
fi