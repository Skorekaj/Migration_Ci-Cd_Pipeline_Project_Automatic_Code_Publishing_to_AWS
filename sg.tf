data "aws_vpc" "default" {
 default = true
}

resource "aws_security_group" "web_server_sg_tf" {
 name        = "web-server-sg-tf"
 description = "Allow Rules for web servers"
 vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "allow_ssh" {
 type              = "ingress"
 description       = "ssh ingress"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 cidr_blocks       = ["0.0.0.0/0"]
 security_group_id = aws_security_group.web_server_sg_tf.id
}
resource "aws_security_group_rule" "allow_Sonar" {
 type              = "ingress"
 description       = "SonarQube ingress"
 from_port         = 9000
 to_port           = 9000
 protocol          = "tcp"
 cidr_blocks       = ["0.0.0.0/0"]
 security_group_id = aws_security_group.web_server_sg_tf.id
}

resource "aws_security_group_rule" "allow_8080" {
 type              = "ingress"
 description       = "Jenkins"
 from_port         = 8080
 to_port           = 8080
 protocol          = "tcp"
 cidr_blocks       = ["0.0.0.0/0"]
 security_group_id = aws_security_group.web_server_sg_tf.id
}
resource "aws_security_group_rule" "allow_80" {
 type              = "ingress"
 description       = "Jenkins"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 cidr_blocks       = ["0.0.0.0/0"]
 security_group_id = aws_security_group.web_server_sg_tf.id
}

resource "aws_security_group_rule" "allow_all" {
 type              = "egress"
 description       = "allow all"
 from_port         = 0
 to_port           = 0
 protocol          = "-1"
 cidr_blocks       = ["0.0.0.0/0"]
 security_group_id = aws_security_group.web_server_sg_tf.id
}
