# Use full Python 3.12 image (includes distutils and build tools)
FROM python:3.12

# Set environment variables
ENV POETRY_VERSION=1.3.1
ENV POETRY_VIRTUALENVS_CREATE=false
ENV POETRY_NO_INTERACTION=1
ENV POETRY_NO_ANSI=1

# Set working directory inside container
WORKDIR /app

# Copy project files
COPY . /app

# Upgrade pip and install poetry
RUN pip install --upgrade pip \
    && pip install "poetry==$POETRY_VERSION"

# Install dependencies with poetry (no dev, no interaction)
RUN poetry install --no-dev

# Expose port your app listens on
EXPOSE 8000

# Command to run the app
CMD ["python", "main.py"]
