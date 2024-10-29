resource "aws_instance" "http" {
  count         = 2
  ami           = var.amazon_linux_ami_id
  instance_type = "t3.micro"

  key_name = aws_key_pair.key.key_name

  vpc_security_group_ids = [aws_security_group.http_sg.id]

  subnet_id = aws_subnet.private-b.id

  associate_public_ip_address = false
  user_data = base64encode(templatefile("http_init.tpl", {
    redis_host  = aws_instance.redis.private_ip,
    db_host     = aws_instance.mysql.private_ip,
    db_user     = var.db_user,
    db_password = var.db_password,
    db_name     = var.db_name
  }))
  tags = {
    Name = "http${count.index + 1}"
  }
}

output "http_private_ips" {
  value = aws_instance.http.*.private_ip
}

