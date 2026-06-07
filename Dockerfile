FROM python:3.11-slim

WORKDIR /app

COPY lambda/handler.py .

RUN pip install boto3

CMD ["python", "handler.py"]
