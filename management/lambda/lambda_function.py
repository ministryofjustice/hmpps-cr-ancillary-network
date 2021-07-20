import json
import boto3
import os

cwl = boto3.client('logs')

def lambda_handler(event, context):
  '''
  Method invoked by AWS to start the function
  '''
  token = None
  defaultRetentionInDays = int(os.environ['default_log_retention_days'])

  paginator = cwl.get_paginator('describe_log_groups')

  page_iterator = paginator.paginate(
        logGroupNamePrefix='/',
        PaginationConfig={'PageSize':10, 'StartingToken':token })

  for page in page_iterator:
    print("token " , token)

    for pg in page["logGroups"]:
      if 'retentionInDays' in pg:
        continue
      else:
        lgName=pg["logGroupName"]
        print(lgName)

        response = cwl.put_retention_policy(
          logGroupName = lgName,
          retentionInDays = defaultRetentionInDays
        )
    try:
      token = page["nextToken"]
    except KeyError:
      break


  body = {
      "message": "Function Successful",
  }

  response = {
      "statusCode": 200,
      "body": json.dumps(body)
  }

  return response
