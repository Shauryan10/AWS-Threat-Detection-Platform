import json
import boto3
import os
from datetime import datetime

LOCAL_MODE = os.environ.get("LOCAL_MODE", "false").lower() == "true"

sns = boto3.client("sns")
dynamodb = boto3.resource("dynamodb")

TABLE_NAME = os.environ.get("TABLE_NAME", "security-incidents")
SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN", "dummy-topic")

table = dynamodb.Table(TABLE_NAME)

THREAT_SEVERITY = {
    "CreateAccessKey": "HIGH",
    "DeleteTrail": "CRITICAL",
    "StopLogging": "CRITICAL",
    "PutBucketPolicy": "HIGH",
    "AuthorizeSecurityGroupIngress": "HIGH"
}

AUTO_RESPONSE_MODE = "dry-run"


def lambda_handler(event, context):
    print("Received Event:")
    print(json.dumps(event))

    detail = event.get("detail", {})

    event_name = detail.get("eventName", "Unknown")
    source_ip = detail.get("sourceIPAddress", "Unknown")

    user_identity = detail.get("userIdentity", {})
    username = user_identity.get("arn", "Unknown")

    severity = THREAT_SEVERITY.get(event_name, "MEDIUM")

    if event_name == "CreateAccessKey":
        auto_response = "Would disable newly created access key"
    elif event_name == "DeleteTrail":
        auto_response = "Would re-enable CloudTrail immediately"
    elif event_name == "StopLogging":
        auto_response = "Would restart CloudTrail logging"
    elif event_name == "AuthorizeSecurityGroupIngress":
        auto_response = "Would revoke dangerous ingress rule"
    elif event_name == "PutBucketPolicy":
        auto_response = "Would revert risky bucket policy"
    else:
        auto_response = "No automated response configured"

    incident = {
        "incident_id": str(datetime.utcnow().timestamp()),
        "event_name": event_name,
        "severity": severity,
        "username": username,
        "source_ip": source_ip,
        "timestamp": datetime.utcnow().isoformat(),
        "auto_response": auto_response,
        "mode": AUTO_RESPONSE_MODE
    }

    if LOCAL_MODE:
        print("LOCAL MODE: DynamoDB insert skipped")
        print("Incident:")
        print(json.dumps(incident, indent=2))
    else:
        table.put_item(Item=incident)

    message = f"""
AWS SECURITY INCIDENT DETECTED

Event: {event_name}
Severity: {severity}
User: {username}
Source IP: {source_ip}

AUTO RESPONSE:
{auto_response}

Mode: {AUTO_RESPONSE_MODE}
"""

    if LOCAL_MODE:
        print("LOCAL MODE: SNS alert skipped")
        print("Alert Message:")
        print(message)
    else:
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject=f"[{severity}] AWS Security Alert",
            Message=message
        )

    return {
        "statusCode": 200,
        "body": json.dumps("Threat processed successfully")
    }