#!/bin/bash

# Download the content from the URL and save it to a temporary file
temp_file="/tmp/hosts_temp"
curl -LsS "https://gitee.com/frankwuzp/github-host/raw/main/hosts" > "$temp_file"

# Function to check if the marker exists in /etc/hosts
marker_exists() {
    grep -Fq "$1" /etc/hosts
}

# Define the begin and end markers
begin_marker="# BEGIN Github Hosts"
end_marker="# END Github Hosts"

# Backup the original /etc/hosts file
cp /etc/hosts /etc/hosts_backup

# If the markers already exist, remove the old custom section
if marker_exists "$begin_marker"; then
    sed -i "/$begin_marker/,/$end_marker/d" /etc/hosts
fi

# Add the begin marker to the /etc/hosts file
echo "$begin_marker" >> /etc/hosts

# Read the downloaded content line by line from the temporary file and append to /etc/hosts
while IFS= read -r line; do
    # Check if the line is not empty
    if [ -n "$line" ]; then
        echo "$line" >> /etc/hosts
    fi
done < "$temp_file"

# Add the end marker to the /etc/hosts file
echo "$end_marker" >> /etc/hosts

# Cleanup the temporary file
rm "$temp_file"

echo "Hosts file updated successfully at $(date +'%Y-%m-%d_%H-%M-%S')"

