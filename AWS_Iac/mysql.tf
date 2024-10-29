resource "aws_instance" "mysql" {
  ami           = var.amazon_linux_ami_id
  instance_type = "t3.micro"

  key_name = aws_key_pair.key.key_name

  vpc_security_group_ids = [aws_security_group.mysql_sg.id]

  subnet_id = aws_subnet.private-b.id

  associate_public_ip_address = false
  user_data = base64encode(templatefile("mysql_init.tpl", {
    mysql_root_password = var.mysql_root_password
    mysql_database      = var.mysql_database
  }))

  tags = {
    Name = "mysql"
  }
}

output "mysql_private_ips" {
  value = aws_instance.mysql.private_ip
}

