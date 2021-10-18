FROM python:3.9-slim
LABEL maintainer="abhishek"

# set environment variables
# Prevents Python from buffering stdout and stderr but send it to terminal
ENV PYTHONUNBUFFERED=1
# Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE=1

COPY . /app/
WORKDIR /app
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# run the web service on container startup, gunicorn webserver is used with one worker and eight threads
# for environments with multiple CPU cores the number of workers can be increased to equal the number of cores available
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
