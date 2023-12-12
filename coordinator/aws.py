import os
import getpass
import boto3
import json
import time

stop=False
def handler(signal_received, frame):
    global stop
    stop=True
def get_bucket_list(s3_path):
    bucket = s3_path.split('/')[2]
    mu_bucket=s3.Bucket(bucket)
    bucket_keys= {}
    for obj in mu_bucket.objects.all():
        bucket_keys[obj.key]=obj.e_tag
    return bucket_keys

def download_file_from_s3(s3_path,s3_files):
    bucket = s3_path.split('/')[2]
    for k,v in s3_files.items():
        s3.Object(bucket,k).download_file(user_path+k)



def get_e_tag_file_to_s3(s3_path, local_path):
    bucket = s3_path.split('/')[2]
    file_path = '/'.join(s3_path.split('/')[3:])
    obj=s3.Object(bucket, file_path)
    return obj.e_tag

def upload_file_to_s3(s3_path, files_to_upload, user_path):
    bucket = s3_path.split('/')[2]
    for k, v in files_to_upload.items():
        file_path = k.replace(user_path,'')
        print(f"file to be uploaded: {file_path}")
        response = obj=s3.Object(bucket, file_path).upload_file(k)


def delete_file_from_s3(s3_path, files_to_delete, user_path):
    bucket = s3_path.split('/')[2]
    for k in files_to_delete:
        file_path = k.replace(user_path,'')
        print(f"file to be removed: {file_path}")
        object=s3.Object(bucket, file_path)
        res=object.delete()

def get_stamp_file_from_local(path):
    files_stamps= {}
    for i in os.scandir(path):
        if i.is_file():
            if ".json" in i.path:
                continue
            if "wifi_list.csv" in i.path:
                continue

            f=i.path
            files_stamps[f] = os.path.getmtime(i.path)
        elif i.is_dir() and (not "logs" in i.path):
            files_stamps.update(get_stamp_file_from_local(i.path))
    return files_stamps

print("This script uploads the SF events JSON to s3")



user=getpass.getuser()
if user=='jacobi':
    pycmd="python3"
else:
    pycmd="python"
if (user!='jacobi'):
    user_path='/home/' + user + '/Scrivania/abh/utenti/'
else:
    user_path='/home/' + user + '/projects/abh/utenti/'

while (not stop):
    time.sleep(10)
    if not os.path.isfile(user_path + 'credential.json'):
        print("ERROR NO CREDENTIAL")
        continue
    with open(user_path + 'credential.json') as json_file:
        credentials = json.load(json_file)

    s3_bucket= credentials['BUCKET']
    ACCESS_ID = credentials['ACCESS_ID']
    ACCESS_KEY = credentials['ACCESS_KEY']
    s3 = boto3.resource('s3',
                        aws_access_key_id=ACCESS_ID,
                        aws_secret_access_key=ACCESS_KEY)





    # read last s3 files e_tag
    if not os.path.isfile(user_path+'last_read_s3.json'):
        last_bucket_keys = {}
    else:
        with open(user_path+'last_read_s3.json') as json_file:
            last_bucket_keys = json.load(json_file)

    # get attual s3 e_tag
    bucket_keys = get_bucket_list(s3_bucket)

    # check for new files and download them
    differenza = dict(set(bucket_keys.items())-set(last_bucket_keys.items()))
    download_file_from_s3(s3_path=s3_bucket, s3_files=differenza)


    # read last s3 files local time_stamp
    if not os.path.isfile(user_path+'last_read_local.json'):
        last_local_files_stamps = {}
    else:
        with open(user_path+'last_read_local.json') as json_file:
            last_local_files_stamps = json.load(json_file)


    local_files_stamps=get_stamp_file_from_local(user_path)


    local_difference = dict(set(local_files_stamps.items())-set(last_local_files_stamps.items()))
    upload_file_to_s3(s3_path=s3_bucket,files_to_upload=local_difference,user_path=user_path)

    deleted_files=list(set(last_local_files_stamps.keys()) - set(local_files_stamps.keys()))
    print(f"files to be deleted: {deleted_files}")
    delete_file_from_s3(s3_path=s3_bucket,files_to_delete=deleted_files,user_path=user_path)

    with open(user_path + 'last_read_local.json', 'w') as convert_file:
        convert_file.write(json.dumps(local_files_stamps))

        #upload_file_to_s3(s3_path, local_path)

    # store new s3 files e_tag
    bucket_keys=get_bucket_list(s3_bucket)
    with open(user_path+'last_read_s3.json', 'w') as convert_file:
      convert_file.write(json.dumps(bucket_keys))

