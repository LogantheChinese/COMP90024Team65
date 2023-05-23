# Use an official Python runtime as the base image
FROM python:3.7
# Set the working directory in the container
WORKDIR /app

ADD . /app

# Set the environment variables
ENV COUCHDB_USERNAME=admin
ENV COUCHDB_PASSWORD=admin
ENV COUCHDB_HOST=localhost
ENV COUCHDB_PORT=5984
ENV COUCHDB_DATABASE=tweet
# ENV HUGE_JSON_TWEET=/data/twitter-huge.json

# Install the required Python packages
RUN pip install textblob couchdb ijson && \
    apt install -y unzip && \
    chmod +x /app/start.sh

# # Set the entrypoint to execute the Python script
# ENTRYPOINT ["python", "tweet.py"]

# # Mount a data volume to the host's ./data directory
# VOLUME ["/data"]

# # Allow the container to access the host machine's network
# # Note: Using --network=host can have security implications, so use with caution
# # Replace the CMD statement if you want to override it when running the container
# CMD ["--network=host"]

ENTRYPOINT ["/app/start.sh"]