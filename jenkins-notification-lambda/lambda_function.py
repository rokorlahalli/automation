import json
import requests
import boto3
from requests.auth import HTTPBasicAuth
from botocore.exceptions import ClientError
    
def lambda_handler(event, context):
    for record in event['Records']:
        process_message(record)

def process_message(record):
    try:
        sns_message = record['Sns']['Message']
        job_name, build_number = sns_message.split(', ')

        # Jenkins credentials
        username = 'jenkins-read-only'
        api_token = 'Tech@1234'

        # Jenkins URL
        jenkins_url = 'http://10.11.6.27:8080'

        # Jenkins API endpoint to get console output
        api_endpoint = f'/job/{job_name}/{build_number}/consoleText'

        # Construct the URL
        url = jenkins_url + api_endpoint

        # Send a GET request to Jenkins API
        response = requests.get(url, auth=HTTPBasicAuth(username, api_token))

        # Check if the request was successful (status code 200)
        if response.status_code == 200:
            # Get the console output text
            console_output = response.text
            print(console_output)

            # Check if "Finished" is not in the console output
            if "Finished" not in console_output:
                print("The word 'Finished' is not found in the console output. Skipping further processing.")
                return  # Exit the function

            if "Finished: SUCCESS" in console_output:
                message = f"The Build of Job: {job_name} with build number: {build_number} is successful"
            elif "Finished: ABORTED" in console_output:
                message = f"The Build of Job: {job_name} with build number: {build_number} is aborted"
            else:
                message = f"The Build of Job: {job_name} with build number: {build_number} is not successful\n{console_output}"

            # Send message to SNS topic
            subject = f'{job_name}:{build_number} - Deployment Status'
            sns_topic_arn = 'arn:aws:sns:us-west-2:255411255437:mail-notifications-jenkins-topic'
            sns_client = boto3.client('sns', region_name='us-west-2')
            send = sns_client.publish(
                TopicArn=sns_topic_arn,
                Subject=subject,
                Message=message
            )
            print("Message sent to SNS topic:", send['MessageId'])

        else:
            print(f"Failed to fetch data from Jenkins. Status code: {response.status_code}")
            print("Response content:")
            print(response.text)
    
    except Exception as e:
        print("An error occurred")
        raise e
        