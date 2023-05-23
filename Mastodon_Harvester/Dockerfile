# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Set environment variables
ENV COUCHDB_HOST=COUCHDB_HOST
ENV COUCHDB_PORT=COUCHDB_PORT
ENV COUCHDB_DATABASE=COUCHDB_DATABASE
ENV COUCHDB_USERNAME=COUCHDB_USERNAME
ENV COUCHDB_PASSWORD=COUCHDB_PASSWORD
ENV ACCOUNT_MAIL=ACCOUNT_MAIL
ENV ACCOUNT_PASSWORD=ACCOUNT_PASSWORD
ENV ACCOUNT_FILE=ACCOUNT_FILE
ENV SERVER_URL=SERVER_URL

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Run hundler.py when the container launches
CMD ["python", "mastodon_stream.py"]
