#!/usr/bin/env python3

import boto3    
from pprint import pprint
ec2client = boto3.client('ec2')
response = ec2client.describe_instances()
for reservation in response["Reservations"]:
    for instance in reservation["Instances"]:
        #pprint(instance)
        print(instance["InstanceId"])
        print(instance["PublicIpAddress"])
