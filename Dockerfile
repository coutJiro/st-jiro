# Use official python 3.12 slim image
FROM python:3.12

# Install system dependencies for cffi, distutils, and building wheels
RUN apt-get update && apt-get install -y --no-install-recommends \
    libffi-dev \
    build-essential \
    pkg-config \
    gcc \
    python3-distutils \
    python3.12-distutils \
    python3.12-venv \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /app

# Copy all project files into container
COPY . /app

# Upgrade pip and install poetry
RUN pip install --upgrade pip
RUN pip install poetry==1.3.1

# Disable poetry creating virtual environments inside container
ENV POETRY_VIRTUALENVS_CREATE=false

# Install Python dependencies without dev packages and without interaction
RUN poetry install --no-dev --no-interaction --no-ansi

# Expose port (make sure it matches your app port)
EXPOSE 8000

# Run your main application
CMD ["python", "main.py"]
