FROM python:3.12

# Install system dependencies, including distutils
RUN apt-get update && apt-get install -y python3-distutils libffi-dev build-essential

# Set environment variables
ENV POETRY_VERSION=1.3.1
ENV POETRY_VIRTUALENVS_CREATE=false
ENV POETRY_NO_INTERACTION=1
ENV POETRY_NO_ANSI=1

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip \
    && pip install "poetry==$POETRY_VERSION"

RUN poetry install --no-dev

EXPOSE 8000

CMD ["python", "main.py"]
