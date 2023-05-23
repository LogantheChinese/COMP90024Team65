#!/bin/bash

# Set the working directory
cd /mnt/data

# Use wget to download the file from the link provided in the environment variable
echo "Downloading the file from $TWITTER_FILE_LINK if it doesn't exist..."
wget -nc $TWITTER_FILE_LINK -O twitter.zip

# Unzip the downloaded file
echo "Unzipping the file..."
unzip -n twitter.zip

# Get the filename of the unzipped file
FILENAME=$(unzip -l twitter.zip | awk '{print $4}' | tail -n 3 | head -n 1)

# Combine the working directory with the filename to get the full path
FILEPATH=$(pwd)/$FILENAME

# Export the file path to the environment variable
export HUGE_JSON_TWEET=$FILEPATH
echo "Unzipping complete, the file path is $HUGE_JSON_TWEET"

# Run the Python script
echo "Starting to processing tweets..."
start=$(date +%s)
python /app/tweet.py
python_exit_status=$?

# Get the end time and calculate the runtime
end=$(date +%s)
runtime=$((end-start))

if [ $python_exit_status -eq 0 ]; then
    echo "Processing tweets finished in $runtime seconds."
    echo "Cleaning up the storage..."
    rm -rf /mnt/data/*
else
    echo "Python script failed with exit status $python_exit_status."
    echo "Skipping cleanup."
fi