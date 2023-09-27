FROM python:3.10-alpine AS builder

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /srv

RUN pip install --upgrade pip
RUN apk add \
    python3-dev \
    file \
    make \
    gcc \
    g++ \
    git \
    musl-dev \
    libc-dev \
    libzmq \
    zeromq-dev \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    postgresql-dev \
    cargo \
    redis

# Install dependencies
COPY . /srv/
COPY requirements.txt /srv/requirements.txt
RUN pip install -r requirements.txt

# Copy project
WORKDIR /srv/sample
CMD python python manage.py migrate && \
    python python manage.py collectstatic --no-input && \
    python manage.py runserver
