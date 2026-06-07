resource "aws_sns_topic" "security_alerts" {
  name = "security-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = "projectmania99@gmail.com"

}

resource "aws_dynamodb_table" "incident_table" {
  name         = "security-incidents"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "incident_id"

  attribute {
    name = "incident_id"
    type = "S"
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-security-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_custom_policy" {

  name = "lambda-custom-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sns:Publish"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "custom_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_custom_policy.arn
}


resource "aws_lambda_function" "security_lambda" {

  filename      = "../lambda_function.zip"
  function_name = "security-threat-handler"
  role          = aws_iam_role.lambda_role.arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"

  source_code_hash = filebase64sha256("../lambda_function.zip")

  environment {
    variables = {
      TABLE_NAME    = aws_dynamodb_table.incident_table.name
      SNS_TOPIC_ARN = aws_sns_topic.security_alerts.arn
    }
  }
}

resource "aws_cloudwatch_event_rule" "security_events" {

  name = "security-events"

  event_pattern = jsonencode({
    source = ["custom.security"]

    detail-type = ["AWS API Call via CloudTrail"]

    detail = {
      eventName = [
        "CreateAccessKey",
        "DeleteTrail",
        "StopLogging",
        "PutBucketPolicy",
        "AuthorizeSecurityGroupIngress"
      ]
    }
  })
}
resource "aws_cloudwatch_event_target" "lambda_target" {

  rule = aws_cloudwatch_event_rule.security_events.name
  arn  = aws_lambda_function.security_lambda.arn
}


resource "aws_lambda_permission" "allow_eventbridge" {

  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.security_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.security_events.arn
}




