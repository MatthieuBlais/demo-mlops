FROM python:3.8-slim

ENV PYTHONPATH /app

COPY requirements.txt .

RUN pip3 install -r requirements.txt

WORKDIR /app

COPY app/ .

ENTRYPOINT [ "bash" ]