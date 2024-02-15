#! /bin/bash
# Update package 
sudo apt update
 
# Install Docker package
sudo apt install -y docker.io
 
# Install Git   
#sudo apt install -y git
 
# Install Docker-Compose
sudo apt install -y docker-compose
 
# Add current user to the docker group (to run Docker without sudo)
sudo usermod -aG docker $USER
 
# Start & enable the Docker service
sudo systemctl start docker
sudo systemctl enable docker
 
# Clone Git repository
git clone https://github.com/mudassirsh/3-Tier-Flask-App.git
 
# Change into the folder to execute docker-compose
cd 3-Tier-Flask-App/3-Tier-Project-with-AWS/
 
# Run Docker Compose with build
docker-compose up --build -d
