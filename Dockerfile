FROM  dokken/centos-8
RUN   yum install unzip git jq -y
RUN   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm -rf aws*
COPY  mongo.repo /etc/yum.repos.d/mongo.repo
RUN   yum install git curl mongodb-org -y
RUN   curl -o /rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
COPY  run.sh /
ENTRYPOINT ["bash", "/run.sh"]