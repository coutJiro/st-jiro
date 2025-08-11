# Use official python image (slim version is lighter)
FROM python:3.12-slim

# Install system dependencies for cffi
RUN apt-get update && apt-get install -y libffi-dev build-essential

# Set working directory inside container
WORKDIR /app

# Copy all project files into container
COPY . /app

# Upgrade pip and install poetry
RUN pip install --upgrade pip
RUN pip install poetry==1.3.1

# Install Python dependencies without dev packages and without interaction
RUN poetry install --no-dev --no-interaction --no-ansi

# Expose port (make sure it matches your app port)
EXPOSE 8000

# Command to run your app
CMD ["python", "main.py"]
