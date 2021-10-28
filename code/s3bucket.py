#/usr/bin/python
import sys
import boto3

try:
    def main():
        bucket_name = sys.argv[1]
        create_s3bucket(bucket_name)

except Exception as error_catch:
    print(error_catch)

def create_s3bucket(bucket_name):
    s3_bucket = boto3.client("s3")
    bucket = s3_bucket.create_bucket(Bucket=bucket_name)
    print(bucket)

if __name__ == '__main__':
    main()
