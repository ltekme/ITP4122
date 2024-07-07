#!/bin/bash
mkdir -p ~/.aws
cp $(dirname "$0")/.aws_account ~/.aws/credentials
sed -i '1s/.*/[default]/' ~/.aws/credentials
cat << EOF > ~/.aws/config
[default]
region = us-east-1
output = json
EOF