#!/bin/bash

git clone "https://github.com/Revanthsatyam/$component.git"

aws_ssm() {
  aws ssm get-parameter --name "$1" --with-decryption --query "Parameter.Value" --output text
}

if [ "${schema_type}" == "DOCDB" ]; then
  mongo_host=$(aws_ssm docdb.prod.endpoint)
  user_name=$(aws_ssm docdb.prod.master_username)
  password=$(aws_ssm docdb.prod.master_password)

  mongo --ssl --host $mongo_host:27017 --sslCAFile /rds-combined-ca-bundle.pem --username $user_name --password $password <catalogue/schema/catalogue.js
fi