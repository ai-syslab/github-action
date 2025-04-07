FROM python:3.10-slim

# Install system-level dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y curl && \
    rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy in the Poetry files first to leverage Docker layer caching
COPY pyproject.toml poetry.lock* /app/

# Install Poetry
RUN pip install --no-cache-dir poetry

# Install dependencies
RUN poetry install --no-root --no-dev

# Copy the rest of the code
COPY . /app

# Expose port 8000
EXPOSE 8000

# Start server
CMD ["poetry", "run", "uvicorn", "microservice.app:app", "--host", "0.0.0.0", "--port", "8000"]