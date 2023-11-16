FROM python:3.11.6-slim

WORKDIR /app

# pulled out:
# python3-dev
# postgresql-client
RUN set -xe \
 && pip install pipenv==2023.10.3 poetry==1.6.1 \
 && apt-get update -q \
 && apt-get install -y -q \
       gcc \
       libssl-dev \
       curl \
       git-core \
       gunicorn3 \
       procps \
 && rm -rf /var/lib/apt/lists/* \
           /var/cache/apt/archives
