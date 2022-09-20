FROM python:3.10-slim

WORKDIR /app
RUN set -xe \
  && pip install pipenv poetry=1.2.1 \
  && apt-get update -q \
  && apt-get install -y -q \
        gcc python3-dev libssl-dev \
        curl postgresql-client git-core \
        gunicorn3 postgresql-client

WORKDIR /app
