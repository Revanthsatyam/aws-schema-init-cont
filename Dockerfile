#FROM  amazon/aws-cli:2.15.16
#COPY  mongo.repo /etc/yum.repos.d/mongo.repo
#RUN   yum install git curl mongodb-org-shell -y
#RUN   curl -o /rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
#COPY  run.sh /
#ENTRYPOINT ["bash", "/run.sh"]

FROM amazonlinux:2
RUN yum install -y unzip git jq curl
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && ./aws/install && rm -rf aws awscliv2.zip
# Add MongoDB 6.0 repository
RUN echo -e "[mongodb-org-6.0]\n\
name=MongoDB Repository\n\
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/6.0/x86_64/\n\
gpgcheck=1\n\
enabled=1\n\
gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc" \
> /etc/yum.repos.d/mongodb-org-6.0.repo
RUN yum install -y mongodb-org-shell
RUN curl -o /rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
COPY run.sh /
ENTRYPOINT ["bash", "/run.sh"]