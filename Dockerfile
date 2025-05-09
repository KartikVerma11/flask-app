# # Use an official Python runtime as a parent image
# FROM python:3.9-slim-buster

# # Set the working directory in the container to /app
# WORKDIR /app

# # Add the current directory contents into the container at /app
# COPY . /app

# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Install Java
# RUN apt-get update && \
#     apt-get install -y openjdk-11-jdk && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# # Make port 8000 available to the world outside this container
# EXPOSE 8000

# # Run Gunicorn to serve the Flask app with increased timeout
# # CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--timeout", "120", "app:app"]
# CMD ["gunicorn", "app:app"]

# docker run -p 8000:8000 <image_id>

# NEW VERSION OF DOCKER FILE
# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install system dependencies, including Java (headless)
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set JAVA_HOME just in case
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Expose port 8000 for the app
EXPOSE 8000

# Run the Gunicorn server with increased timeout
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--timeout", "120", "app:app"]
