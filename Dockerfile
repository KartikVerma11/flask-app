# # Use an official Python runtime as a parent image
# FROM python:3.9-slim-buster

# # Set the working directory in the container to /app
# WORKDIR /app

# # Add the current directory contents into the container at /app
# ADD . /app

# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Install Java
# RUN apt-get update && \
#     apt-get install -y openjdk-11-jdk && \
#     apt-get clean;

# # Make port 8000 available to the world outside this container
# EXPOSE 8000

# # Run app.py when the container launches
# CMD ["python", "app.py"]

# # docker run -p 8000:8000 <image_id>



# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Download and setup LanguageTool server
RUN apt-get update && apt-get install -y wget unzip default-jre
RUN wget https://languagetool.org/download/LanguageTool-stable.zip
RUN unzip LanguageTool-stable.zip
RUN mv LanguageTool-*/ LanguageTool/

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run the LanguageTool server and the Flask application
CMD java -cp LanguageTool/languagetool-server.jar org.languagetool.server.HTTPServer --port 8082 & \
    python app.py
