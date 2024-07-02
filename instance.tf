
resource "aws_instance" "Jenkins" {
    ami = "ami-0d18e50ca22537278"
    //instance_type = "t2.micro"
    instance_type = "t2.large"
    tags = {Name = "Jenkins"}
    key_name = "demo" // use an excisting key created in AWS
    vpc_security_group_ids = [aws_security_group.web_server_sg_tf.id]
    user_data = file("${path.module}/docker.sh") // script.sh bash file docker.sh
}

resource "aws_instance" "SonarQube" {
    ami = "ami-0d18e50ca22537278"
  //  instance_type = "t2.micro"
    instance_type = "t2.large"    
    tags = {Name = "SonarQube"}
    key_name = "demo" // use an excisting key from AWS
    vpc_security_group_ids = [aws_security_group.web_server_sg_tf.id]
    user_data = file("${path.module}/docker.sh") // script.sh bash file docker.sh
}\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

resource "aws_instance" "a-Nginx" {
    ami = "ami-0d18e50ca22537278"
    instance_type = "t2.micro"
    tags = {Name = "a-NginX"}
    key_name = "demo" // use an excisting key from AWS
    vpc_security_group_ids = [aws_security_group.web_server_sg_tf.id]
    user_data = file("${path.module}/docker.sh") // script.sh bash file docker.sh
}

output "public_ip_Nginx" {
 description = "The public IP address assigned to the instance."
 value      = [aws_instance.a-Nginx.public_ip]
}

output "public_ip_Jenkins" {
 description = "The public IP address assigned to the instance."
 value      = [aws_instance.Jenkins.public_ip]
}

output "public_ip_SonarQube" {
 description = "The public IP address assigned to the instance."
 value      = [aws_instance.SonarQube.public_ip]
}
