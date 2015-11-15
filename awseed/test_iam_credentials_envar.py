# AWS_ACCESS_KEY_ID - AWS access key.
# AWS_SECRET_ACCESS_KEY - AWS secret key. Access and secret key variables override credentials stored in credential and config files.
# AWS_DEFAULT_REGION - AWS region. This variable overrides the default region of the in-use profile, if set.
#
# env AWS_ACCESS_KEY_ID=AKIAJOVZ2DVGJKZAOJSQ \
#     AWS_SECRET_ACCESS_KEY=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 \
#     AWS_DEFAULT_REGION=ap-southeast-2 \
#     python test_iam_credentials_envar.py
import boto3
s3 = boto3.resource('s3')
for bucket in s3.buckets.all():
    print(bucket.name)
