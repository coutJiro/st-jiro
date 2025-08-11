FROM python:3.11-slim

# Install OS dependencies needed for building Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    pkg-config \
    python3-distutils \
    python3-setuptools \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, wheel to latest versions
RUN python3 -m pip install --upgrade pip setuptools wheel

# Install poetry
RUN pip install poetry==1.3.1

# Set working directory
WORKDIR /app

# Copy your project files
COPY . /app

# Install Python dependencies via poetry (without dev deps)
RUN poetry config virtualenvs.create false \
 && poetry install --no-dev --no-interaction --no-ansi

# Expose the port your app runs on
EXPOSE 8000

# Run your app
CMD ["python", "main.py"]
