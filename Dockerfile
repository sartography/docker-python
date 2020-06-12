FROM python:3.7-slim

RUN set -xe \
  && pip install pipenv \
  && apt-get update -q \
  && apt-get install -y -q \
        gcc python3-dev libssl-dev \
        curl postgresql-client git-core \
        gunicorn3 postgresql-client
