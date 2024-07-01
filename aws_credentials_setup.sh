#!/bin/bash
mkdir -p ~/.aws
cp .aws_account ~/.aws/credentials
sed -i '1s/.*/[default]/' ~/.aws/credentials
cat << EOF > ~/.aws/config
[default]
region = us-east-1
output = json
EOF