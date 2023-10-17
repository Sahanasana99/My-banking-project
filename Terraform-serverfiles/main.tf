resource "aws_instance" "Test-server" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = "Terraform"
  vpc_security_group_ids = ["sg-02007fb447b3ad198"]
  connection {
     type 	= "ssh"
     user		= "ubuntu"
     private_key	= file("./Terraform.pem")
     host		= self.public_ip
}
provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
}
tags = {
  Name = "Test-server"
}
provisioner "local-exec" {
    command = " echo ${aws_instance.Test-server.public_ip} > inventory "
}
provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-project/Terraform-serverfiles/banking-playbook.yml"
}
}
