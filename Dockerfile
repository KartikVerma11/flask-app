# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget && \
    apt-get clean;

# Download LanguageTool server
RUN wget https://languagetool.org/download/LanguageTool-stable.zip && \
    unzip LanguageTool-stable.zip && \
    rm LanguageTool-stable.zip

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Expose port for LanguageTool server
EXPOSE 8081

# Run both LanguageTool server and Flask app
CMD ["sh", "-c", "java -cp LanguageTool-*/languagetool-server.jar org.languagetool.server.HTTPServer --port 8081 & python app.py"]
