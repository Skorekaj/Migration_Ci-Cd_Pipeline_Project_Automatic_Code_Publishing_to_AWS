#!/bin/bash

echo "Migration script starting for Jenkins........."
echo ""
echo "Jenkins   Ec2 instance IP Address: $1 "
echo "SonarQube Ec2 instance IP Address: $2 "
echo ""
#-----------------------------------------------------------------
echo "Docker Export of Jenkins Image OnPrem"
docker save -o /home/jaas/jenkinssonarqubeterraform/jenkins-export.tar jenkins/jenkins
echo "Done!"
echo ""

echo "Zipping up Jenkins Home Folder..........."
zip -r jenkinsHomeFolder.zip /home/jaas/jenkins_home/
echo "Done !"
echo ""

echo "Copying Jenkins homeZipFolder.zip to AWS Jenkins server: $1"
scp -i demo.pem -o StrictHostKeyChecking=no jenkinsHomeFolder.zip ubuntu@$1:/home/ubuntu
echo "Done !"
echo ""

echo "Copying Jenkins docker image to AWS Jenkins server: $1"
scp -i demo.pem -o StrictHostKeyChecking=no jenkins-export.tar ubuntu@$1:/home/ubuntu
echo "Done !"
echo ""

echo "Running SSH, multiple commands ..."
ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@$1 "docker load -i jenkins-export.tar ; sudo hostnamectl set-hostname jenkins ; mkdir jenkins_home ; sudo unzip jenkinsHomeFolder.zip -d /home/ubuntu/ ; sudo chmod -R 777 jenkins_home/ ; docker run -d -it -p 8080:8080 -v /home/ubuntu/jenkins_home:/var/jenkins_home jenkins/jenkins ; exit" 
echo "Done !"
echo ""

# Settig hostname 
#echo "Setting hostname to Jenkins"
#ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@13.41.204.64 'sudo hostnamectl set-hostname jenkins ; exit'
#echo "Done !"
#echo ""

# Make local Jenkins folder
#ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@$1 "mkdir jenkins_home ; exit" 
#echo "Done !"
#echo ""

# Unziping jenkins home folder 
# echo "Unziping Homefolder "
#ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@13.41.204.64 'sudo unzip jenkinsHomeFolder.zip -d /home/ubuntu/ ; exit'
#echo "Done !"
#echo ""

# Change the folder/file permissions so Jnekins can access the home folders
#echo "Setting permissions on Homefolder "
#ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@13.41.204.64 'sudo chmod -R 777 jenkins_home/ ; exit'
#echo "Done!"
#echo ""

# Starting Jenkins Docker Image
#echo "Starting Jenkins Docker Image ..."
#ssh -i demo.pem -o StrictHostKeyChecking=no ubuntu@$1 "docker run -d -it -p 8080:8080 -v /home/ubuntu/jenkins_home:/var/jenkins_home jenkins/jenkins ; exit"
#echo "Done !"
#echo ""


#Starting jenkins Migration script
echo " - Starting SonarQube Migration Script"
./awsMigrationSonarQube.sh $2