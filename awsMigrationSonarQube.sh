#!/bin/bash

echo "Migration script starting for SonarQube........."
echo ""
echo "SonarQube Ec2 instance IP Address: $1 "

echo "Docker Export of SonarQube Image from OnPrem"
docker save -o /home/jaas/jenkinssonarqubeterraform/sonarqube1-export.tar sonarqube1
echo "Done !"
echo ""

echo "Copying SonarQube docker image to AWS SonarQube server: $1"
scp -i demo.pem -o StrictHostKeyChecking=no sonarqube1-export.tar ubuntu@$1:/home/ubuntu
echo "Done !"
echo ""

echo "Running various SSH commands ..."
ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@$1 "docker load -i sonarqube1-export.tar ; docker run -d -it -p 9000:9000 sonarqube1 ; exit" 
echo "Done !"
echo ""
echo ""

echo "Migration Fished !"
