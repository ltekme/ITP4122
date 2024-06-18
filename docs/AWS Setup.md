# Setting up aws cli

create a file called `.aws_account` in the same folder as `aws_setup.sh`

in the file paste in your aws cli crednetial. See example below

```text
[<- access profile ->]
aws_access_key_id=<- access key ->
aws_secret_access_key=<- secret key ->
aws_session_token=<- access token ->
```

Your access crednetials should follw the above format

After pasting in the credentials, execute `aws_setup.sh`. See the contents of the script for details
