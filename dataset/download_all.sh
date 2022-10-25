#!/bin/bash

# Get the top level git directory
gitdir=$(git rev-parse --show-toplevel)

# Define some paths we'll use.
trip_hist="${gitdir}/dataset/trip_histories_index.txt"
stations="${gitdir}/dataset/stations_index.txt"

trips_dir="${gitdir}/dataset/trips/"
stations_dir="${gitdir}/dataset/stations/"

# Create the directories (assuming they don't exist yet).
mkdir -p $trips_dir 
mkdir -p $stations_dir 

# Download the trip history zip files.
for f in $(cat $trip_hist); do
  echo "Downloading ${f} to disk...";
  wget $f -P $trips_dir;
done

# Download the stations .csv
for f in $(cat $stations); do
  echo "Downloading ${f} to disk...";
  wget $f -P $stations_dir;
done

echo "All downloads complete."

# Extract the .zip files
echo "Extracting results..."

for f in $(ls $trips_dir | grep "\.zip"); do
  fullpath="${trips_dir}/${f}";
  echo "Extracting ${fullpath}";
  unzip $fullpath -d $trips_dir;
  rm $fullpath;
done

echo "Done extracting."

