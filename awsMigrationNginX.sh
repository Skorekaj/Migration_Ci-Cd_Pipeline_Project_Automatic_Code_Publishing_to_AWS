#!/bin/bash

echo "Migration script starting........."
echo ""
echo "NginX Ec2 instance IP Address: $1 "
echo "Jenkins Ec2 instance IP Address: $2"
echo "SonarQube Ec2 instance IP Address: $3"

#------------------------ NginX Section -----------------------------------------
echo "Docker Export of NginX Image"
docker save -o /home/jaas/jenkinssonarqubeterraform/nginx-export.tar nginx
echo "Done !"
echo ""

# copy NginX Docker file from On-prem to AWS Docker Ec2 instance
echo "Copying NginX docker image to AWS Docker server: $1"
scp -i demo.pem -o StrictHostKeyChecking=no nginx-export.tar ubuntu@$1:/home/ubuntu
echo "Done !"
echo ""

# Loading NginX Docker file to Docker 
echo "Loadin Nginx Image into AWS docker instance"
ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@$1 "docker load -i nginx-export.tar ; mkdir nginxwebsite ; docker run -it --rm -d -p 80:80 -v /home/ubuntu/nginxwebsite:/usr/share/nginx/html nginx; exit" 
echo "Done !"
echo ""

# Make NginX local website folder
echo "Create NginX webSite Folder" 
#ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@$1 "mkdir nginxwebsite" 
echo "Done !"
echo ""

# start up the NginX docker container !!!!!!!!!!!!!!!!
echo "Starting NginX in Docker Container"
#ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@$1 "docker run -it --rm -d -p 80:80 -v /home/ubuntu/nginxwebsite:/usr/share/nginx/html nginx" 
echo "Done !"
echo ""

# Connect
#ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@$1

#Starting jenkins Migration script
echo " - Starting Jenkins Migration Script"
./awsMigrationJenkins.sh $2 $3