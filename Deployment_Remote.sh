#!/bin/bash

# Ensure the remote directory exists
ssh -i key.pem ec2-user@44.242.217.99 "mkdir -p /home/ec2-user/task-tracker"

# Transfer the project files to the remote VM
scp -i key.pem -r /home/mrwan/Desktop/Giza_Systems/task-tracker/code/* ec2-user@44.242.217.99:/home/ec2-user/task-tracker

echo "Code transferred successfully to 44.242.217.99."

# Build Docker image on the remote VM
ssh -i key.pem ec2-user@44.242.217.99 << EOF
  cd /home/ec2-user/task-tracker
  echo "Starting Docker compose..."
  docker compose up -d
EOF

echo "Docker compose runns successfully on 44.242.217.99."
