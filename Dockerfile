FROM python:3.11-slim

WORKDIR /app

COPY lambda/handler.py .
COPY lambda/test_runner.py .

RUN pip install boto3

ENV AWS_DEFAULT_REGION=ap-south-1
ENV TABLE_NAME=security-incidents
ENV SNS_TOPIC_ARN=dummy-topic
ENV LOCAL_MODE=true

CMD ["python", "test_runner.py"]