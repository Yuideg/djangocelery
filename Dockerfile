FROM python:3.10-alpine AS build-python
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY ./requirements.txt /requirements.txt
RUN pip install -r ./requirements.txt
FROM python:3.10-alpine
LABEL Author = yideg
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBUG 0

ENV PATH="/opt/venv/bin:$PATH"
COPY --from=build-python /opt/venv /opt/venv
RUN pip install --upgrade pip
RUN pip install celery
RUN pip install celery-message-consumer
RUN pip install pika
RUN pip install amqp
RUN pip install asgiref
RUN pip install billiard
RUN pip install celery
RUN pip install click
RUN pip install click-didyoumean
RUN pip install click-repl
RUN pip install Django
RUN pip install kombu
RUN pip install prompt-toolkit
RUN pip install pytz
RUN pip install six
RUN pip install sqlparse
RUN pip install vine
RUN pip install wcwidth
RUN pip install django-celery-results
RUN pip install Redis
RUN mkdir /app
WORKDIR /app
# COPY ./requirements.txt /requirements.txt
# RUN pip install -r ../requirements.txt
COPY ./ /app/
RUN python manage.py collectstatic --noinput
RUN adduser -D user
USER user
CMD gunicorn app.wsgi:application --bind 0.0.0.0:$PORT
