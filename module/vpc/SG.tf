resource "aws_security_group" "jenkins_sg" {
  name = "jenkins_security_group"
  description = "Security group for Jenkins instance"
  vpc_id = "${aws_vpc.eks_vpc.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere (adjust for security)
  }
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access to Jenkins UI from anywhere (adjust for security)
  }
  ingress {
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access to Jenkins UI from anywhere (adjust for security)
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access to Jenkins UI from anywhere (adjust for security)
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic (adjust for security)
  }

  tags = {
    Name = "jenkins_security_group"
  }
}

