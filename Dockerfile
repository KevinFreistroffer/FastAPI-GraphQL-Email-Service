# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY EmailService/ ./EmailService/
COPY serverless.yml .

# Set environment variables (these will be overridden by actual values)
ENV SMTP_SERVER=smtp.gmail.com \
    SMTP_PORT=587 \
    SENDER_EMAIL="" \
    SENDER_PASSWORD=""

# Expose port if needed (for local testing)
EXPOSE 8000

# Command to run the application
CMD ["python", "-m", "EmailService.handler"]
