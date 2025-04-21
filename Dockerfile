FROM  amazon/aws-cli:2.15.16
RUN   yum install git curl mongodb-org-shell -y
RUN   curl -o rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
COPY  run.sh /
ENTRYPOINT ["bash", "/run.sh"]