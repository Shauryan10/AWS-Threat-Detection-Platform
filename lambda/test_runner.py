from handler import lambda_handler

test_event = {
    "detail": {
        "eventName": "CreateAccessKey",
        "sourceIPAddress": "5.6.7.8",
        "userIdentity": {
            "arn": "local-test-user"
        }
    }
}

response = lambda_handler(test_event, None)
print(response)