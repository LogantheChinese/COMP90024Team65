#!/bin/bash

# Set the working directory
cd /mnt/data

# Use wget to download the file from the link provided in the environment variable
echo "Downloading the file from $TWITTER_FILE_LINK..."
wget $TWITTER_FILE_LINK -O twitter.zip

# Unzip the downloaded file
echo "Unzipping the file..."
unzip twitter.zip

# Get the filename of the unzipped file
FILENAME=$(unzip -l twitter.zip | awk '{print $4}' | tail -n 1)

# Combine the working directory with the filename to get the full path
FILEPATH=$(pwd)/$FILENAME

# Export the file path to the environment variable
export HUGE_JSON_TWEET=$FILEPATH
echo "Unzipping complete, the file path is $HUGE_JSON_TWEET"

# Run the Python script
echo "Starting to processing tweets..."
start=$(date +%s)
python /app/tweet.py

# Get the end time and calculate the runtime
end=$(date +%s)
runtime=$((end-start))
echo "Processing tweets finished in $runtime seconds."