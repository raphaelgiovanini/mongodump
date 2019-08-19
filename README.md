# DUMP mongodb to S3

This file is for backing up each of the collections to s3, in case you need to restore individually

## Create a AWS user to read and write dump

Login to IAM to create user and get access information

https://console.aws.amazon.com/iam/home

Permissions:
    AmazonS3FullAccess
    Copy ID and Secret to use in awscli

```bash
apt install awscli
```
```bash
aws configure
````
Use ID and SECRET generate in IAM

```bash
aws s3 ls
```

## Configure dump.sh

Change DB and AUTH variables to your bank settings
If you do not use authentication, leave it empty:

AUTH=""

```bash
bash dump.sh
```
