# Use Gradle to build the application
FROM gradle:latest AS builder

# Set work directory
WORKDIR /app

#WORKDIR /Users/yuchenli/Downloads/back-end

# Copy your source code into the image
COPY --chown=gradle:gradle . /app

# Build the application
RUN gradle clean build

# Start a new stage to reduce the final image size
FROM openjdk:17.0.1-jdk-slim

# Copy the jar file from the builder stage
COPY --from=builder /app/build/libs/CCC-0.0.1-SNAPSHOT.jar /app/app.jar

# Set environment variables
ENV TWEET_COUCHDB_HOST="http://172.26.133.116"
ENV MASTODON_COUCHDB_HOST="http://172.26.133.116"
ENV TWEET_COUCHDB_PORT="31000"
ENV MASTODON_COUCHDB_PORT="31000"
ENV SUDO_COUCHDB_DATABASE="sudo"
ENV TWEET_COUCHDB_USERNAME="admin"
ENV MASTODON_COUCHDB_USERNAME="admin"
ENV MASTODON_COUCHDB_PASSWORD="fM2ViRNmR3X6CLrXhe4X"
ENV TWEET_COUCHDB_PASSWORD="fM2ViRNmR3X6CLrXhe4X"
ENV TWEET_COUCHDB_DATABASE="tweet"
ENV MASTODON_COUCHDB_DATABASE="mastodon"

# Run the jar file
ENTRYPOINT ["java","-jar","/app/app.jar"]
