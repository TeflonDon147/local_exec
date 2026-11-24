
resource "aws_instance" "teflon" {
  ami                    = data.aws_ami.teflon.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = var.key

  tags = {
    Name = var.tags
  }
}

resource "null_resource" "teflon" {
  triggers = {
    public_ip = aws_instance.teflon.public_ip
  }
  connection {
    type        = "ssh"
    host        = aws_instance.teflon.public_ip
    private_key = file("~/Downloads/maya.pem")
    user        = "ec2-user"
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "echo \"<h1>Welcome to Teflon Don's world!</h1>\" | sudo tee /var/www/html/index.html",
      "sudo systemctl status httpd --no-pager",
    ]
  }
}