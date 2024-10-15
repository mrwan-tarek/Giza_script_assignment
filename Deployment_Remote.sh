#!/bin/bash

# Ensure the remote directory exists
ssh -i key.pem ubuntu@35.91.233.210 "mkdir -p /home/ubuntu/task-tracker"

# Transfer the project files to the remote VM
scp -i key.pem -r /home/mrwan/Desktop/Giza_Systems/crud_task/code* ubuntu@35.91.233.210:/home/ubuntu/task-tracker

echo "Code transferred successfully to 35.91.233.210."

# Build Docker image on the remote VM
ssh -i key.pem ubuntu@35.91.233.210 << EOF
  cd /home/ubuntu/task-tracker/code
  echo "Starting Docker compose..."
  docker compose up -d
EOF

echo "Docker compose runns successfully on 35.91.233.210."
