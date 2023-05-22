# Use Gradle to build the application
FROM gradle:latest AS builder

ARG MY_WDR

# Set work directory
WORKDIR ${MY_WDR}

#WORKDIR /Users/yuchenli/Downloads/back-end

# Copy your source code into the image
COPY --chown=gradle:gradle . .

# Build the application
RUN gradle clean build

# Start a new stage to reduce the final image size
FROM openjdk:17.0.1-jdk-slim

ARG MY_JAR
# Copy the jar file from the builder stage
COPY --from=builder ${MY_JAR}/build/libs/CCC-0.0.1-SNAPSHOT.jar /app/app.jar

# Set environment variables
ENV TWEET_COUCHDB_HOST="https://couchdb.quantumlab.cloud"
ENV MASTODON_COUCHDB_HOST="http://172.26.133.116"
ENV TWEET_COUCHDB_PORT="443"
ENV MASTODON_COUCHDB_PORT="31000"
ENV COUCHDB_SUDO="sudo"
ENV TWEET_COUCHDB_USERNAME="admin"
ENV MASTODON_COUCHDB_USERNAME="admin"
ENV MASTODON_COUCHDB_PASSWORD="fM2ViRNmR3X6CLrXhe4X"
ENV TWEET_COUCHDB_PASSWORD="admin"
ENV COUCHDB_TWEET="tweet_demo_2"
ENV COUCHDB_MASTODONDB="mastodon"

# Mount a data volume to the host's ./data directory
VOLUME ["/data"]

# Run the jar file
ENTRYPOINT ["java","-jar","/app/app.jar"]
