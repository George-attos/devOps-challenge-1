# Use official Python slim image
FROM python:3.12-slim

# Set working directory inside container
WORKDIR /app

# Install Python dependencies directly
RUN pip install --no-cache-dir Flask pytest

# Copy the hello folder (where app.py resides)
COPY hello/ ./hello

# Set working directory to hello
WORKDIR /app/hello

# Expose the port the Flask app runs on
EXPOSE 5000

# Set the default command to run the Flask app
CMD ["python", "app.py"]
