resource "aws_instance" "jenkins_server" {
  ami           = var.ec2_ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  subnet_id = aws_subnet.eks_public_subnet[0].id  # Deploy in the first public subnet

  # User data script to install Jenkins and Docker (replace with your actual script)
  user_data = <<-EOF
    #!/bin/bash
    set -e

    # Update the package repository
    sudo apt-get update

    # Install Java
    sudo apt-get install -y fontconfig openjdk-17-jre

    # Add Jenkins repository key
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

    # Add Jenkins repository
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Update the package repository again
    sudo apt-get update

    # Install Jenkins
    sudo apt-get install -y jenkins

    # Enable and start Jenkins service
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
  EOF

  tags = {
    Name = "jenkins_server"
  }
}
