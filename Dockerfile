# Use official python image
FROM python:3.12-slim

# Install system dependencies for cffi and distutils
RUN apt-get update && apt-get install -y \
    libffi-dev \
    build-essential \
    pkg-config \
    gcc \
    python3-distutils \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /app

# Copy all project files into container
COPY . /app

# Upgrade pip, setuptools, wheel
RUN pip install --upgrade pip setuptools wheel

# Install poetry
RUN pip install poetry==1.3.1

# Disable poetry virtualenv creation to install in system env
RUN poetry config virtualenvs.create false

# Show versions for debugging
RUN python3 --version && pip --version && poetry --version

# Install dependencies without dev packages
RUN poetry install --no-dev --no-interaction --no-ansi

# Expose port (should match your app port)
EXPOSE 8000

# Run the app
CMD ["python", "main.py"]
