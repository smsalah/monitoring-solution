import os
import time
import boto
from boto.s3.key import Key
from boto.s3.connection import S3Connection
#aws_access_key_id = 'AKIAINMJVDBAUCL6H6HQ'
#aws_secret_access_key = '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'
REGION_HOST = 's3.ap-south-1.amazonaws.com'


def upload_to_s3(aws_access_key_id, aws_secret_access_key, file, bucket, key,
                 callback=None, md5=None, reduced_redundancy=False,
                 content_type=None):
    try:
        size = os.fstat(file.fileno()).st_size
    except:
        file.seek(0, os.SEEK_END)
        size = file.tell()
    #conn = boto.connect_s3(aws_access_key_id, aws_secret_access_key)
    conn = S3Connection(aws_access_key_id,aws_secret_access_key, host=REGION_HOST)
    #bucket='icingabucket'
    bucket = conn.get_bucket(bucket, validate=True)
    k = Key(bucket)
    k.key = key
    if content_type:
        k.set_metadata('Content-Type', content_type)
    sent = k.set_contents_from_file(file, cb=callback, md5=md5,
                                    reduced_redundancy=reduced_redundancy,
                                    rewind=True)
    file.seek(0)
    if sent == size:
        return True
    return False
