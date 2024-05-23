# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set environment variables
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONUNBUFFERED=1

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget unzip && \
    apt-get clean

# Create a non-root user and group
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Adjust permissions for the /app directory
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Download and unzip LanguageTool
RUN wget https://languagetool.org/download/LanguageTool-stable.zip && \
    unzip LanguageTool-stable.zip && \
    rm LanguageTool-stable.zip

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run app.py when the container launches
CMD ["python", "app.py"]
