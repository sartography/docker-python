FROM python:3.8-slim

WORKDIR /app
COPY Pipfile Pipfile.lock /app/

RUN set -xe \
  && pip install pipenv \
  && apt-get update -q \
  && apt-get install -y -q \
        gcc python3-dev libssl-dev \
        curl postgresql-client git-core \
        gunicorn3 postgresql-client \
  && pipenv install --dev

WORKDIR /app
