# Use an official Python runtime as the base image
FROM python:3.7

# Set the working directory in the container
WORKDIR /app

# Set the environment variables
ENV COUCHDB_USERNAME=admin
ENV COUCHDB_PASSWORD=admin
ENV COUCHDB_HOST=couchdb.quantumlab.cloud
ENV COUCHDB_PORT=443
ENV COUCHDB_DATABASE=sudo
ENV EXCEL_FILE_NAME=/data/all-regions-abs-sa4-time-series_march-2023.xlsx

# Copy the Python script to the container
COPY sudo_upload.py /app/sudo_upload.py

# Install the required Python packages
RUN pip install pandas couchdb openpyxl

# Create a directory for the data volume
RUN mkdir /data

# Set the entrypoint to execute the Python script
ENTRYPOINT ["python", "sudo_upload.py"]

# Mount a data volume to the host's ./data directory
VOLUME ["/data"]

# Allow the container to access the host machine's network
# Note: Using --network=host can have security implications, so use with caution
# Replace the CMD statement if you want to override it when running the container
CMD ["--network=host"]
