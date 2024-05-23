# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run Gunicorn to serve the Flask app
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--timeout", "120", "app:app"]

# Health check to ensure the container is running properly
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl --fail http://localhost:8000/health || exit 1

# docker run -p 8000:8000 <image_id>

# change this to dockerFile