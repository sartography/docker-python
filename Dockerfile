FROM python:3.11-slim

WORKDIR /app
RUN set -xe \
  && pip install pipenv poetry==1.2.2 \
  && apt-get update -q \
  && apt-get install -y -q \
        gcc \
        python3-dev \
        libssl-dev \
        curl \
        postgresql-client \
        git-core \
        gunicorn3

WORKDIR /app
