#FROM  amazon/aws-cli:2.15.16
#COPY  mongo.repo /etc/yum.repos.d/mongo.repo
#RUN   yum install git curl mongodb-org-shell -y
#RUN   curl -o /rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
#COPY  run.sh /
#ENTRYPOINT ["bash", "/run.sh"]

FROM amazonlinux:2

# Install basic utilities
RUN yum install -y unzip git jq curl

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && ./aws/install && rm -rf aws awscliv2.zip

# Add MongoDB 4.2 repository (with your specified configuration)
RUN echo -e "[mongodb-org-4.2]\n\
name=MongoDB Repository\n\
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.2/x86_64/\n\
gpgcheck=0\n\
enabled=1" \
> /etc/yum.repos.d/mongodb-org-4.2.repo

# Install MongoDB shell package
RUN yum install -y mongodb-org-shell

# Download RDS certificate bundle
RUN curl -o /rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

# Copy and set up entrypoint
COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["bash", "/run.sh"]