#!/bin/bash
sudo curl https://d3g5vo6xdbdb9a.cloudfront.net/yum/opendistroforelasticsearch-artifacts.repo -o /etc/yum.repos.d/opendistroforelasticsearch-artifacts.repo
sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install wget unzip
sudo yum install opendistroforelasticsearch-1.13.2 -y
sudo ln -s /usr/lib/jvm/java-1.8.0/lib/tools.jar /usr/share/elasticsearch/lib/
sudo mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch-old.yml
sudo aws s3 cp s3://kms-tutorial/config.yml /tmp
private_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
node_name=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
(sed -e "s/node_name/$node_name/" -e "s/\private_ip/$private_ip/" /tmp/config.yml) > /tmp/elasticsearch.yml
sudo mv /tmp/elasticsearch.yml /etc/elasticsearch/
sudo systemctl start elasticsearch.service