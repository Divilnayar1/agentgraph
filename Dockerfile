FROM python:3.10-slim-bookworm

# Set working directory inside the container
WORKDIR /app

# Copy dependency list first (better caching for pip install)
COPY requirements.txt .

# Install system dependencies + Python deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project (including configs, src, envchatbot, etc.)
COPY . .

# Set PYTHONPATH so you can import from src/, envchatbot/, etc.
ENV PYTHONPATH=/app

# Start the app (adjust this path based on where your main script lives)
CMD ["python", "src/app.py"]
