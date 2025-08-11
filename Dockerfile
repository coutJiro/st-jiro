FROM python:3.12-slim

RUN apt-get update && apt-get install -y libffi-dev build-essential python3-distutils

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip
RUN pip install poetry==1.3.1

ENV POETRY_VIRTUALENVS_CREATE=false

RUN poetry install --no-dev --no-interaction --no-ansi

EXPOSE 8000

CMD ["python", "main.py"]
