FROM amazonlinux:2
RUN yum install -y unzip git jq curl
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && ./aws/install && rm -rf aws awscliv2.zip \
COPY mongo.repo /etc/yum.repos.d/mongodb-org-4.2.repo
RUN yum install -y mongodb-org-shell
RUN curl -o /rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["bash", "/run.sh"]