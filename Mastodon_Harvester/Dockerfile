# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Set environment variables
ENV DBCONFIG_ADDRESS=DB_ADDRESS
ENV DBCONFIG_PORT=DB_PORT
ENV DBCONFIG_DB=DB_CONFIG
ENV DB_USERNAME=DB_USERNAME
ENV DB_PASSWORD=DB_PASSWORD
ENV ACCOUNT_MAIL=ACCOUNT_MAIL
ENV ACCOUNT_PASSWORD=ACCOUNT_PASSWORD
ENV ACCOUNT_FILE=ACCOUNT_FILE
ENV SERVER_URL=SERVER_URL

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Run hundler.py when the container launches
CMD ["python", "mastodon_stream.py"]
