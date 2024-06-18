# make the dir
mkdir -p ~/.aws

# copy the .aws_account content to default aws credentials
cp .aws_account ~/.aws/credentials

# replace what ever the credential name is
sed -i '1s/.*/[default]/' ~/.aws/credentials

# additional aws cli config
cat << EOF > ~/.aws/config
[default]
region = us-east-1
output = json
EOF