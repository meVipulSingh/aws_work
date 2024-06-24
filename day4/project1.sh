#!/bin/bash
#Author: Vipul Singh
#Date: 23/06/24
<<comment
This is project of deploying notes app in ec2 instance on AWS.
We will install all the dependencies which is required to run this project.
STEPS:
	*First we clone the code from github to our VM.
	*Then we install all the dependencies that is required to run this project.
	*Last we deploy this app to the server any handle all the errors.
comment


code_clone() {
	echo "Cloning the notes-app....."
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements() {
	echo "Installing dependencies....."
	sudo apt-get install docker.io nginx -y docker-compose
}

required_restarts() {
	sudo chown $USER /var/run/docker.sock
	#sudo systemctl enable docker
	#sudo systemctl enable nginx
	#sudo systemctl restart docker
}

deploy() {
	docker build -t notes-app .
	#docker run -d -p 8000:8000 notes-app:latest
	docker compose up -d
}

echo "********DEPLOYMENT STARTED********"
if ! code_clone; then
	echo "The code directory already exists"
	cd django-notes-app
fi
if ! install_requirements; then
	echo "Installation failed"
	exit 1
fi

if ! required_restarts; then
	echo "System fault identified"
	exit 1
fi
if ! deploy; then
	echo "Deployment failed mailing the admin"
	#sendingmail
	exit 1
fi
echo "********DEPLOYMENT COMPLETED********"
